#!/usr/bin/env ruby

"""
    Intergalactic Planetary
    Planetary Intergalactic
    Another Dimension
    Beastie Boys known to let the beat drop - :-)

 """

require './lib/conversionrules'

def teste
    puts "rafael"
end
if ARGV.empty?
  puts "Usage : ruby #{__FILE__} <input.txt>"
else
  filename = ARGV[0]
  begin
    @lv_conversion_rules = ConversionRules.new
    File.open(filename, "r").each_line do |lv_line|
      lv_line.chomp!
      next if lv_line.empty? || lv_line =~ /^#/

      @lv_conversion_rules.insert_queries lv_line
      lv_result = @lv_conversion_rules.launch
      puts lv_result if lv_result

    end
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end
end