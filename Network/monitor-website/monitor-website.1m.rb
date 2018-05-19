#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# <bitbar.title>Monitor HTTP</bitbar.title>
# <bitbar.author>simonini</bitbar.author>
# <bitbar.author.github>simonini</bitbar.author.github>
# <bitbar.desc>Monitoring in real time for websites.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.version>1.0</bitbar.version>
# <bitbar.image>https://raw.githubusercontent.com/simonini/Monitor-Website-Bitbar/master/monitor-website-image.png</bitbar.image>
# <bitbar.abouturl>https://github.com/simonini/Monitor-Website-Bitbar</bitbar>
# Monitor WEBSITE
#

require 'net/http'
require 'uri'
require './setting'
require './monitor'

HTTP_ERRORS = [
  EOFError,
  Errno::ECONNRESET,
  Errno::EINVAL,
  Net::HTTPBadResponse,
  Net::HTTPHeaderSyntaxError,
  Net::ProtocolError,
  Timeout::Error
]

websites = []
Setting.websites.each do |url|
  print "---------\n"
  url = URI.parse(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = url.scheme == 'https'
  begin
    p "begin"
    response = http.get(url)
    case response
    when Net::HTTPSuccess then
      response
    when Net::HTTPRedirection then
      location = response['location']
      warn "redirected to #{location}"
      p "--------------"
      p "redirect"
      #fetch(location, limit - 1)
    else
      response.value
    end
    code = response.code
    websites.push({code: code, url: url})
  rescue *HTTP_ERRORS => error
    p "errrroreeee"
    p error
    websites.push({code: "Wrong url!", url: url})
  end
  # For debug decomment this line:
  puts "#{url.host} - #{code}| href=#{url} color=##{Setting.code_color code}"
end

monitor = Monitor.new(websites: websites)
puts monitor.get_status()
