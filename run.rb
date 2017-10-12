# -*- coding: utf-8 -*-
require 'roo'
require_relative 'src/shift_reader'
require_relative 'src/ical_maker'

if ARGV[0].nil? || ARGV[1].nil? || ARGV[2].nil?
  puts "USAGE:\n"
  puts '$ ruby calmake.rb [excel file] [from] [to]'
  print 'Ex. $ ruby calmake.rb test.xlsx 山田 2017-10-01 2017-10-05'
end

excel = Roo::Excelx.new(ARGV[0])
name = ARGV[1]
from = DateTime.parse(ARGV[2])
to = DateTime.parse(ARGV[3])
shift_list = ShiftReader.new(excel, name, from, to).run
puts IcalMaker.new(shift_list).to_s
