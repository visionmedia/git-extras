#!/usr/bin/ruby
#
# Renders GitHub-flavored Markdown to HTML
#
# render_gh_markdown.rb <file> ...
#
# Requires the github-markup gem to be installed. Rendered output is
# written to .html files next to the original input files.

# TODO: Figure out how to generate anchors. The index links in Commands.md 
# aren't working when rendered locally with this, though they do work when
# viewed on GitHub.

require 'optparse'
require 'github/markup'

options = {}
OptionParser.new do |opts|
	opts.banner = "Usage: render_gh_markdown.rb <file> ..."
	opts.on("-v", "--verbose", "Run verbosely") do |v|
		options[:verbose] = v
	end
end.parse!

infiles = ARGV

if infiles.empty?
	$stderr.puts("Error: no files specified")
	abort
end

for infile in infiles do
	basefile = infile.gsub(/\.[^.]*$/, '')
	outfile = basefile + ".html"
	html = GitHub::Markup.render(infile)
	File.write(outfile, html)
	puts "#{infile} -> #{outfile}" if options[:verbose]
end