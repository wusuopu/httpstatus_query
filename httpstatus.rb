#!/usr/bin/env ruby
#-*- coding:utf-8 -*-

# Copyright (C) 
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; If not, see <http://www.gnu.org/licenses/>.
# 
# 2014 - Long Changjin <admin@longchangjin.cn>

require "json"

$path = File.dirname File.realpath __FILE__

def show_status_list
  (1..5).each do |i|
    file = File.join($path, "codes/#{i}.json")
    data = JSON::load File.read file
    puts "#{data['class']['class']}XX - #{data['class']['title']}"
    data['codes'].each do |k, v|
      puts "\t#{v['code']}(#{v['title']})   #{v['summary']}"
    end
  end
end

def query_status_code code
  if code.length == 1 then
    i = code
    code = nil
  else
    i = code[0]
  end
  file = File.join($path, "codes/#{i}.json")
  data = JSON::load File.read file
  if code && data['codes'][code] then
    value = data['codes'][code]
    puts "#{value['code']}(#{value['title']})   #{value['summary']}"
  else
    puts "#{data['class']['class']}XX - #{data['class']['title']}"
    data['codes'].each do |k, v|
      puts "\t#{v['code']}(#{v['title']})   #{v['summary']}"
    end
  end
end

if caller.length == 0
  if ARGV.length == 0 then    # display all status
    puts "Usage: #{$0} [code]"
    show_status_list
    exit
  end
  code = ARGV[0]

  if code.length != 1 && code.length != 3 then
    exit
  end
  if code.length == 1 && !(1..5).include?(code.to_i) then
    exit
  end

  query_status_code code
end
