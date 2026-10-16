# frozen_string_literal: true

require_relative "../_plugins/cv_bibliography"

source = <<~BIBTEX
  @misc{paper,
    title = {Workshop paper},
    author = {Ortega, Tomàs},
    year = {2026},
    url = {https://openreview.net/forum?id=gInXazr59f&noteId=123}
  }
BIBTEX

entry = CvBibliography::Parser.new(source).parse.first
html = CvBibliography::EntryFormatter.new(entry).call
link = '<a class="cv-publication-link" href="https://openreview.net/forum?id=gInXazr59f&amp;noteId=123">' \
       "openreview.net/forum?id=gInXazr59f&amp;noteId=123</a>"
raise "Bibliography URL link is missing or incorrectly escaped" unless html.include?(link)

entry.fields["url"] = +"https://www.openreview.net/forum?id=gInXazr59f"
html = CvBibliography::EntryFormatter.new(entry).call
raise "Bibliography URL label includes a prefix" unless html.include?(">openreview.net/forum?id=gInXazr59f</a>")

entries = [
  ["year_only", { "year" => "2026" }],
  ["month_only", { "year" => "2026", "month" => "10" }],
  ["older_year", { "year" => "2025", "month" => "12", "day" => "31" }],
  ["earlier_day", { "year" => "2026", "month" => "10", "day" => "2" }],
  ["earlier_month", { "year" => "2026", "month" => "9", "day" => "30" }],
  ["same_date_z", { "year" => "2026", "month" => "10", "day" => "3", "author" => "Zulu" }],
  ["same_date_b", { "year" => "2026", "month" => "10", "day" => "3", "title" => "Beta" }],
  ["same_date_a", { "year" => "2026", "month" => "10", "day" => "3", "title" => "Alpha" }]
].map do |key, fields|
  fields = { "author" => "", "title" => "" }.merge(fields).transform_values(&:dup)
  CvBibliography::Entry.new(type: "misc", key: key, fields: fields)
end

renderer = CvBibliography::Renderer.new(entries)
actual = renderer.bibliography.scan(/<li id="publication-([^"]+)"/).flatten
expected = %w[same_date_a same_date_b same_date_z earlier_day month_only earlier_month year_only older_year]
raise "Bibliography date order is incorrect: #{actual.inspect}" unless actual == expected

numbers = renderer.citation(%w[older_year same_date_a]).scan(%r{>\d+</a>})
raise "Citation numbers do not follow date order" unless numbers == [">1</a>", ">8</a>"]

puts "Bibliography checks passed."
