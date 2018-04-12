# For period in university
module Period
  def period1(day)
    [
      DateTime.new(day.year, day.month, day.day, 9, 0, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 10, 40, 0, 0.375)
    ].freeze
  end

  def period2(date)
    [
      DateTime.new(date.year, date.month, date.day, 10, 50, 0, 0.375),
      DateTime.new(date.year, date.month, date.day, 12, 30, 0, 0.375)
    ].freeze
  end

  def period25(date)
    [
      DateTime.new(date.year, date.month, date.day, 12, 30, 0, 0.375),
      DateTime.new(date.year, date.month, date.day, 13, 20, 0, 0.375)
    ].freeze
  end

  def period3(day)
    [
      DateTime.new(day.year, day.month, day.day, 13, 20, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 15, 0, 0, 0.375)
    ].freeze
  end

  def period4(day)
    [
      DateTime.new(day.year, day.month, day.day, 15, 10, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 16, 50, 0, 0.375)
    ].freeze
  end

  def period5(day)
    [
      DateTime.new(day.year, day.month, day.day, 17, 0, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 17, 50, 0, 0.375)
    ].freeze
  end

  def period6(day)
    [
      DateTime.new(day.year, day.month, day.day, 18, 0, 0, 0.375),
      DateTime.new(day.year, day.month, day.day, 19, 0, 0, 0.375)
    ].freeze
  end
end
