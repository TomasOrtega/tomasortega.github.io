# frozen_string_literal: true

require "cgi"
require "liquid"
require "uri"

# Renders the CV's constrained BibTeX source as citations and a bibliography.
module CvBibliography
  class ParseError < StandardError; end

  Entry = Data.define(:type, :key, :fields)

  # Parses braced, quoted, and bare BibTeX fields.
  class Parser
    ENTRY_PATTERN = /^@(?<type>[A-Za-z]+)\s*\{\s*(?<key>[^,\s]+)\s*,(?<body>.*?)^\}\s*$/m
    FIELD_PATTERN = /
      ^\s*(?<name>[A-Za-z][\w-]*)\s*=\s*
      (?:
        \{(?<braced>(?:[^{}]|\{\g<braced>\})*)\}
        |
        "(?<quoted>(?:[^"\\]|\\.)*)"
        |
        (?<bare>[^,\s]+)
      )
      \s*,?\s*$
    /mx

    def initialize(source)
      @source = source
    end

    def parse
      entries = entry_matches.map do |match|
        Entry.new(
          type: match[:type].downcase,
          key: match[:key],
          fields: fields_for(match[:body], match[:key])
        )
      end
      raise ParseError, "bibliography contains unsupported syntax" unless @source.gsub(ENTRY_PATTERN, "").strip.empty?

      ensure_unique(entries.map(&:key), "bibliography key")
      entries
    end

    private

    def entry_matches
      @source.to_enum(:scan, ENTRY_PATTERN).map { Regexp.last_match }
    end

    def fields_for(body, key)
      pairs = field_matches(body, key).map { |match| field_pair(match) }
      ensure_unique(pairs.map(&:first), "field in #{key.inspect}")
      pairs.to_h
    end

    def field_matches(body, key)
      matches = body.to_enum(:scan, FIELD_PATTERN).map { Regexp.last_match }
      remainder = body.gsub(FIELD_PATTERN, "").gsub(/[\s,]/, "")
      raise ParseError, "entry #{key.inspect} contains an unsupported field" unless remainder.empty?

      matches
    end

    def field_pair(match)
      value = match[:braced] || match[:quoted] || match[:bare]
      [match[:name].downcase, value]
    end

    def ensure_unique(values, description)
      duplicate = values.tally.find { |_value, count| count > 1 }
      raise ParseError, "duplicate #{description} #{duplicate.first.inspect}" if duplicate
    end
  end

  # Normalizes small pieces of TeX and escapes generated HTML.
  module Text
    module_function

    def plain(value)
      text = strip_macros(value.to_s)
      text.gsub!("\\&", "&")
      text.gsub!(/\\([_%#])/, "\\1")
      text.tr!("{}", "")
      text.gsub!("~", " ")
      text.gsub!("--", "-")
      text.gsub!(/\s+/, " ")
      text.strip
    end

    def strip_macros(value)
      loop do
        updated = value.gsub(/\\(?:textbf|emph|textit)\{([^{}]*)\}/, "\\1")
        return value if updated == value

        value = updated
      end
    end

    def html(value)
      CGI.escapeHTML(value.to_s)
    end

    def attribute(value)
      html(value)
    end
  end

  # Formats one parsed publication.
  class EntryFormatter
    def initialize(entry)
      @entry = entry
      @fields = entry.fields
    end

    def call
      parts = [
        "#{formatted_authors}.",
        %(<span class="cv-publication-title">#{Text.html(Text.plain(@fields.fetch('title', '')))}</span>.)
      ]
      parts << formatted_venue unless formatted_venue.empty?
      parts << formatted_link unless formatted_link.empty?
      parts.join(" ")
    end

    private

    def formatted_authors
      @fields.fetch("author", "").split(/\s+and\s+/).map { |author| formatted_author(author) }.join(", ")
    end

    def formatted_author(raw_author)
      family, given = author_parts(raw_author)
      name = Text.html(Text.plain([given, family].reject(&:empty?).join(" ")))
      return "<strong>#{name}</strong>" if own_name?(family, given)

      name
    end

    def author_parts(raw_author)
      parts = raw_author.split(",").map(&:strip)
      return [parts.first, parts.drop(1).join(" ")] if parts.length > 1

      words = raw_author.split
      [words.pop.to_s, words.join(" ")]
    end

    def own_name?(family, given)
      Text.plain(family) == "Ortega" && Text.plain(given).match?(/\A(?:Tomàs|T\.?)\z/)
    end

    def formatted_venue
      parts = [venue_name, venue_details].reject(&:empty?)
      parts.empty? ? "" : "#{parts.join(', ')}."
    end

    def venue_name
      venue = @fields["journal"] || @fields["booktitle"]
      return "" unless present?(venue)

      prefix = @entry.type == "inproceedings" ? "In " : ""
      "#{prefix}<em>#{Text.html(Text.plain(venue))}</em>"
    end

    def venue_details
      details = [volume_and_number, pages, Text.plain(@fields.fetch("year", ""))]
      details.reject(&:empty?).map { |part| Text.html(part) }.join(", ")
    end

    def volume_and_number
      return "" unless present?(@fields["volume"])

      volume = Text.plain(@fields["volume"])
      present?(@fields["number"]) ? "#{volume}(#{Text.plain(@fields['number'])})" : volume
    end

    def pages
      present?(@fields["pages"]) ? "pp. #{Text.plain(@fields['pages'])}" : ""
    end

    def formatted_link
      url, label = link_data
      return "" unless url

      uri = URI.parse(url)
      return "" unless %w[http https].include?(uri.scheme)

      %(<a class="cv-publication-link" href="#{Text.attribute(uri)}">#{Text.html(label)}</a>)
    rescue URI::InvalidURIError
      ""
    end

    def link_data
      return doi_link if present?(@fields["doi"])
      return arxiv_link if present?(@fields["eprint"])

      [nil, nil]
    end

    def doi_link
      doi = Text.plain(@fields["doi"])
      ["https://doi.org/#{doi}", "doi:#{doi}"]
    end

    def arxiv_link
      eprint = Text.plain(@fields["eprint"])
      ["https://arxiv.org/abs/#{eprint}", "arXiv:#{eprint}"]
    end

    def present?(value)
      value && !Text.plain(value).empty?
    end
  end

  # Numbers publications and produces citation links.
  class Renderer
    def initialize(entries)
      @entries = entries.sort_by do |entry|
        [-year(entry), Text.plain(entry.fields.fetch("author", "")), Text.plain(entry.fields.fetch("title", ""))]
      end
      @entries_by_key = @entries.to_h { |entry| [entry.key, entry] }
      @numbers = @entries.each_with_index.to_h { |entry, index| [entry.key, index + 1] }
    end

    def citation(keys)
      validate_keys(keys)
      sorted_keys = keys.uniq.sort_by { |key| @numbers.fetch(key) }
      links = sorted_keys.map { |key| citation_link(key) }
      label = "#{sorted_keys.one? ? 'Reference' : 'References'} " \
              "#{sorted_keys.map { |key| @numbers.fetch(key) }.join(', ')}"
      %(<span class="cv-citation" aria-label="#{Text.attribute(label)}">[#{links.join(', ')}]</span>)
    end

    def bibliography
      items = @entries.map do |entry|
        %(<li id="publication-#{Text.attribute(entry.key)}">#{EntryFormatter.new(entry).call}</li>)
      end
      %(<ol class="cv-bibliography">\n#{items.join("\n")}\n</ol>)
    end

    private

    def year(entry)
      Integer(Text.plain(entry.fields.fetch("year", "0")), exception: false) || 0
    end

    def validate_keys(keys)
      missing = keys.reject { |key| @entries_by_key.key?(key) }
      raise ParseError, "unknown citation key(s): #{missing.join(', ')}" unless missing.empty?
    end

    def citation_link(key)
      number = @numbers.fetch(key)
      %(<a href="#publication-#{Text.attribute(key)}" aria-label="Reference #{number}">#{number}</a>)
    end
  end

  def self.renderer(context)
    site = context.registers.fetch(:site)
    relative_path = site.config.fetch("cv_bibliography", "_bibliography/publications.bib")
    source = File.read(File.join(site.source, relative_path), encoding: "UTF-8")
    Renderer.new(Parser.new(source).parse)
  rescue Errno::ENOENT, ParseError => e
    raise Jekyll::Errors::FatalException, "CV bibliography: #{e.message}"
  end

  # Expands a list of BibTeX keys into linked citation numbers.
  class CiteTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @keys = markup.split(/[\s,]+/).reject(&:empty?)
      raise Liquid::SyntaxError, "cite requires at least one bibliography key" if @keys.empty?
    end

    def render(context)
      CvBibliography.renderer(context).citation(@keys)
    rescue ParseError => e
      raise Jekyll::Errors::FatalException, "CV bibliography: #{e.message}"
    end
  end

  # Expands to the complete, newest-first publication list.
  class BibliographyTag < Liquid::Tag
    def render(context)
      CvBibliography.renderer(context).bibliography
    end
  end
end

Liquid::Template.register_tag("cite", CvBibliography::CiteTag)
Liquid::Template.register_tag("bibliography", CvBibliography::BibliographyTag)
