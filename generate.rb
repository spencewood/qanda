#!/usr/bin/env ruby

require "optparse"
require "./qanda"

qanda = QandA.new
if qanda.load?("words")
  qanda.process
  qanda.generate_questions
  qanda.generate_answers
end