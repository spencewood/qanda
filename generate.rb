#!/usr/bin/env ruby

require "optparse"
require "./qanda"

options = {}
file_name = "words"
OptionParser.new do |opts|
  opts.banner = "Usage: generate.rb [options]"
  opts.on("--word-file FILE",
    'FILE with word list to parse. Will default to "words".') do |name|
    file_name = name
  end
  opts.on("--ignore-case", "-i",
    "Convert fragments to lowercase to avoid duplicate case matches.") do
    options[:ignore_case] = true
  end
  opts.on("--skip-apos", "-a",
    "Skip adding any fragments with an apostrophe.") do
    options[:skip_apos] = true
  end
  opts.on("--skip-num", "-n",
    "Skip adding any fragments with numbers.") do
    options[:skip_num] = true
  end
end.parse!

qanda = QandA.new(options)
if qanda.load?(file_name)
  qanda.process
  qanda.generate_questions
  qanda.generate_answers
else
  puts "Unable to load word file!"
end