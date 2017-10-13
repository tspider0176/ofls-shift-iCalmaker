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
#{header}
#{@date_list.map { |arr| v_event('修学支援室TA', '修学支援室', arr[0], arr[1]) }.join("\n")}
END:VCALENDAR"""
  end

  def header
    """PRODID:-//tspider0176//calmaker//EN
VERSION:2.0
CALSCALE:GREGORIAN
BEGIN:VTIMEZONE
TZID:Asia/Tokyo
TZURL:http://tzurl.org/zoneinfo-outlook/Asia/Tokyo
X-LIC-LOCATION:Asia/Tokyo
BEGIN:STANDARD
TZOFFSETFROM:+0900
TZOFFSETTO:+0900
TZNAME:JST
DTSTART:19700101T000000
END:STANDARD
END:VTIMEZONE"""
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
DTSTART;TZID=\"Asia/Tokyo\":#{date_to_vcal_date(dtstart)}
DTEND;TZID=\"Asia/Tokyo\":#{date_to_vcal_date(dtend)}
END:VEVENT"""
  end
end
