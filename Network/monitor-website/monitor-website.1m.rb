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
require_relative './lib/setting'
require_relative './lib/site'
require_relative './lib/monitor'

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
  url_parsed = URI.parse(url)
  site = Site.new(url: url)
  result = site.call()
  websites.push(result)
  #p result
  # For debug decomment this line:
  puts "#{url_parsed.host} - #{result[:code]}| href=#{url_parsed} color=##{Setting.code_color result[:code]}"
end
#p "websites: #{websites}"

monitor = Monitor.new(websites: websites)
puts monitor.get_status()
