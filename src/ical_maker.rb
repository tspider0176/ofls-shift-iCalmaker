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
<<-EOS
BEGIN:VCALENDAR
#{header}

#{@date_list.map { |arr| v_event('修学支援室TA', '修学支援室', arr[0], arr[1]) }.join("\n")}
END:VCALENDAR
EOS
  end

  def header
    "PRODID:-//tspider0176//calmaker//EN\nVERSION:2.0\nCALSCALE:GREGORIAN"
  end

  def uuid
    `uuidgen`.chomp
  end

  def vcal_time_now
    now = DateTime.now
    "#{now.hour}#{now.minute}#{now.second}T#{now.year}#{now.month}#{now.day}"
  end

  def date_to_vcal_date(date)
    date.strftime('%Y%m%dT%H%M%S')
  end

  def v_event(summary, location, dtstart, dtend)
<<-EOS
BEGIN:VEVENT
DTSTAMP:#{vcal_time_now}Z
UID:#{uuid}
SUMMARY:#{summary}
DESCRIPTION:#{summary}
LOCATION:#{location}
DTSTART;TZID=\"Asia/Tokyo\":#{date_to_vcal_date(dtstart)}
DTEND;TZID=\"Asia/Tokyo\":#{date_to_vcal_date(dtend)}
END:VEVENT
EOS
  end
end
