class Monitor

  def initialize websites:
    @websites = websites
  end

  def get_status
    @websites.each do |website|
      code = website[:code]
      color = "color=##{Setting.code_color code}"
      # 401 sta per non autorizzato ma vuol dire che comunque è online
      if code != "200" and code != "401"
        `afplay "/Users/#{Setting.user}/bitbar/sound/alarm.mp3"`
        return "#{website[:url]} #{website[:code]} | #{color} | #{website[:url]} | href=#{website[:url]} | #{color}"
      end
    end
    return "OK | color=##{Setting.code_color 200}"
  end

end
