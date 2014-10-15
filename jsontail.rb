#!/usr/bin/env ruby

require 'json'
require 'pp'

def get_keyval(parents, myHash)
  myHash.collect do |key, value|
    if value.is_a?(Hash)
      result = get_keyval("#{parents.nil? ? '' : parents + '.'}#{key}", value)
      unless result.empty?
        result.join(' - ')
      end
    else
      if key == '@timestamp' && parents.nil?
        ''
      else
        "#{parents.nil? ? '' : parents + '.'}#{key}=#{value}"
      end
    end
  end
end

STDIN.read.split("\n").each do |line|
  data = JSON.parse(line)
  output = ''

  timestamp = if data['@timestamp']
                data.delete('@timestamp')
              elsif data['time']
                data.delete('time')
              else
                ''
              end
  output += timestamp + ' '

  host = if data['host']
          data.delete('host')
        else
          ''
        end
  output += host + ' '

  level = if data['level']
          data.delete('level')
        else
          ''
        end
  output += level.upcase + ' '

  application = if data['application']
          data.delete('application')
        elsif data['app']
          data.delete('app')
        elsif data['@source']
          data.delete('@source')
        else
          ''
        end
  output += application + ' '

  pid = if data['pid']
          data.delete('pid')
        else
          ''
        end
  output += pid.to_s + ' '

  message = if data['message']
          data.delete('message')
        else
          ''
        end
  output += '"' + message + '" - '

  result = get_keyval(nil, data)
  unless result.empty?
    output += result.join(' - ')
  end

  puts output
end
