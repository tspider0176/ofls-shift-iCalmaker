# -*- coding: utf-8 -*-
require 'roo'

# For period in university
module Period
  def period1(day)
    [
      DateTime.new(day.year, day.month, day.day, 9, 0, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 10, 30, 0, 0.375)
    ].freeze
  end

  def period2(date)
    [
      DateTime.new(date.year, date.month, date.day, 10, 40, 0, 0.375),
      DateTime.new(date.year, date.month, date.day, 12, 10, 0, 0.375)
    ].freeze
  end

  def period25(date)
    [
      DateTime.new(date.year, date.month, date.day, 12, 10, 0, 0.375),
      DateTime.new(date.year, date.month, date.day, 13, 10, 0, 0.375)
    ].freeze
  end

  def period3(day)
    [
      DateTime.new(day.year, day.month, day.day, 13, 10, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 14, 40, 0, 0.375)
    ].freeze
  end

  def period4(day)
    [
      DateTime.new(day.year, day.month, day.day, 14, 50, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 16, 20, 0, 0.375)
    ].freeze
  end

  def period5(day)
    [
      DateTime.new(day.year, day.month, day.day, 16, 30, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 18, 0, 0, 0.375)
    ].freeze
  end

  def period6(day)
    [
      DateTime.new(day.year, day.month, day.day, 18, 0, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 19, 0, 0, 0.375)
    ].freeze
  end
end

# Open excel file
class ShiftReader
  include Period

  def initialize(excel, name, from, to)
    @excel = excel
    @name = name
    @from = from
    @to = to
  end

  def run
    shift_array
  end

  private

  def shift_array
    find_target_rows
      .map { |hash| hash.delete_if { |key, val| key != 'A' && val != @name } }
      .map { |hash| hash.keys.map { |key| make_daterange(key, hash['A']) } }
      .flatten
      .reject(&:nil?)
      .each_slice(2).to_a
  end

  def find_target_rows
    (4..@excel.last_row)
      .map { |num| ('A'..'S').map { |row_char| date_cell(row_char, num) }.to_h }
      .select { |hash| hash['A'].between?(@from, @to) }
  end

  def date_cell(row, col)
    [row, @excel.cell(row, col)]
  end

  # 1st = start, 2nd = end
  def make_daterange(row_char, day)
    case row_char
    when 'B', 'C'
      period1(day)
    when 'D', 'E'
      period2(day)
    when 'F', 'G', 'H'
      period25(day)
    when 'I', 'J', 'K'
      period3(day)
    when 'L', 'M', 'N'
      period4(day)
    when 'O', 'P', 'Q'
      period5(day)
    when 'R', 'S'
      period6(day)
    end
  end
end

# The class creating ical text from the list
class IcalMaker
  def initialize(date_list)
    @date_list = date_list
  end

  def to_s
    create_text
  end

  private

  def create_text
    """BEGIN:VCALENDAR
#{header}#{@date_list.map { |arr| v_event('修学支援室TA', '修学支援室', arr[0], arr[1]) }.join}
END:VCALENDAR"""
  end

  def header
    """PRODID:-//tspider0176//calmaker//EN
VERSION:2.0
CALSCALE:GREGORIAN"""
  end

  def uuid
    `uuidgen`.chomp
  end

  def vcal_time_now
    now = DateTime.now
    last_mod_date = now.year.to_s + now.month.to_s + now.day.to_s
    last_mod_time = now.hour.to_s + now.minute.to_s + now.second.to_s
    last_mod_date + 'T' + last_mod_time
  end

  def date_to_vcal_date(date)
    date.strftime('%Y%m%dT%H%M%S')
  end

  def v_event(summary, location, dtstart, dtend)
    """BEGIN:VEVENT
DTSTAMP:#{vcal_time_now}Z
UID:#{uuid}
SUMMARY:#{summary}
DESCRIPTION:#{summary}
LOCATION:#{location}
LAST-MODIFIED:#{vcal_time_now}Z
DTSTART:#{date_to_vcal_date(dtstart)}Z
DTEND:#{date_to_vcal_date(dtend)}Z
END:VEVENT"""
  end
end

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
