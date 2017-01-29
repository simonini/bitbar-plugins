#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# <bitbar.title>Monitor HTTP</bitbar.title>
# <bitbar.author>simonini</bitbar.author>
# <bitbar.author.github>simonini</bitbar.author.github>
# <bitbar.desc>Monitoring in real time for websites.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.version>1.0</bitbar.version>
# <bitbar.image>https://raw.githubusercontent.com/simonini/Monitor-Website-Bitbar/master/monitor-website-image.png</bitbar.image>
#
# Monitor WEBSITE
#


require "net/http"
require "uri"

class Setting
  def self.websites 
    ['https://significatocanzone.it/',
      'http://www.goofygoober.it/?locale=it',
      'http://ipy.bartucci.it',
      'http://awai.info']
  end
  def self.user
    'ale'
  end
end



def code_color code
  if code.to_i == 200
    return "00cc00"
  else
    return "ff0000"
  end
end

def get_status status
  status.each do |stato|
    code = stato[:code]
    color = "color=##{code_color code}"
    # 401 sta per non autorizzato ma vuol dire che comunque è online
    if code != "200" and code != "401" 
      
      `afplay "/Users/#{Setting.user}/bitbar/monitor/alarm.mp3"`
      
      return "#{stato[:url]} #{stato[:code]} | #{color} | #{stato[:url]} | href=#{stato[:url]} | #{color}"
    end
  end
  return "OK | color=##{code_color 200}"
end

status = []
Setting.websites.each do |url|
  url = URI.parse(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = url.scheme == 'https'
  response = http.get(url)
  code = response.code
  status.push({code: code, url: url})
  # For debug decomment this line:
  # puts "#{url.host} - #{code}| href=#{url} color=##{code_color code}"
end

puts get_status(status)


