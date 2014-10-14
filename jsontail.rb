#!/usr/bin/env ruby

require 'json'
require 'pp'

def get_keyval(parents, myHash)
  myHash.collect do |key, value|
    if value.is_a?(Hash)
      result = get_keyval("#{parents.nil? ? '' : parents + '.'}#{key}", value)
      unless result.empty?
        result.join(' ')
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

  app = if data['app']
          data.delete('app')
        elsif data['@source']
          data.delete('@source')
        else
          ''
        end
  output += app + ' '

  result = get_keyval(nil, data)
  unless result.empty?
    output += result.join(' ')
  end

  puts output
end
