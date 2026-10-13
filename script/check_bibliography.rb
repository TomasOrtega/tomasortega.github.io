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
link = '<a class="cv-publication-link" href="https://openreview.net/forum?id=gInXazr59f&amp;noteId=123">Paper</a>'
raise "Bibliography URL link is missing or incorrectly escaped" unless html.include?(link)

puts "Bibliography link check passed."
