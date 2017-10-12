require_relative 'period'

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
