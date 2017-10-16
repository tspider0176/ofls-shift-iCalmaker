# -*- coding: utf-8 -*-
require 'roo'
require 'gmail'
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

File.open('events.ics', 'w') do |f|
  f.puts(IcalMaker.new(shift_list).to_s)
end

puts 'Do you send ical file to your smart phone with g-mail? [y/n]'
if STDIN.gets == 'y'
  print 'e-mail >'
  email = STDIN.gets.chomp
  USERNAME = email
  print 'password >'
  PASSWORD = STDIN.gets.chomp

  gmail = Gmail.new(USERNAME, PASSWORD)

  message = gmail.generate_message do
    to email
    subject 'Sending ical file'
    html_part do
      content_type 'text/html; charset=UTF-8'
      body '<h1>ical file for your shift</h1>'
    end
  end

  gmail.deliver(message)
  gmail.logout
end
