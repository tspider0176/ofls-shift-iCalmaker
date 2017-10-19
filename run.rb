# -*- coding: utf-8 -*-
require 'roo'
require 'gmail'
require 'io/console'
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

puts 'Do you send ical file to your G-mail address yourself? [y/n]'
print '> '

if STDIN.gets.chomp == 'y'
  # Read auth info. from auth
  File.open('auth') do |file|
    file.flock File::LOCK_EX
    file.each_line do |info|
      EMAIL = info.split(',')[0].chomp.split('=')[1].delete('"')
      PASSWORD = info.split(',')[1].chomp.split('=')[1].delete('"')
    end
  end

  if EMAIL.nil? || PASSWORD.nil?
    puts 'Assume your address or password.'
  else
    gmail = Gmail.new(EMAIL, PASSWORD)
    message = gmail.generate_message do
      to EMAIL
      subject 'Sending ical file'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<h1>ical file for your shift</h1>'
      end
      add_file 'events.ics'
    end

    gmail.deliver(message)
    gmail.logout
  end
end
