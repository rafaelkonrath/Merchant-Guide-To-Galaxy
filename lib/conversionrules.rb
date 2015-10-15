
require './lib/roman'

class ConversionRules < RomanToDecimal

  def initialize
    @gv_queries = []
    @gv_data = {}
  end

  def insert_queries(pm_queries)
    @gv_queries << pm_queries
  end

  def launch
    lv_result = nil #"I have no idea what you are talking about"
    @gv_queries.each do |lv_queries|
      if lv_queries =~  /^\w+ is [IVXLCDM]$/
        lv_word = lv_queries.split.first
        lv_roman = lv_queries.split.last
        @gv_data[lv_word.to_sym] = {:roman => lv_roman}
        lv_result = nil

      elsif lv_queries =~ /^(\w+ )+(Silver|Gold|Iron) is \d+ Credits$/
        get_value lv_queries
        lv_result = nil

      elsif lv_queries =~ /^how (much|many Credits)? is (\w+ )+(Silver |Gold |Iron )?\?$/
        lv_result = output(lv_queries)

      else
        lv_result = "I have no idea what you are talking about"

      end
    end
    lv_result
  end


  ################
  # .:: Private Methods ::.
  #
  private

  def output(pm_queries)
    pm_queries.sub! /^how /, ""
    if pm_queries =~ /^much/
        pm_queries.sub! /^much is /, ""
        lv_numeral = input(pm_queries, /^\w+ /)
        begin
            lv_value = convert_roman lv_numeral
            lv_text = lv_numeral.reduce{|lv_item, lv_total| lv_item += " #{lv_total}"}
                          "#{lv_text} is #{lv_value}"
            rescue Exception
                "I have no idea what you are talking about"
            end
        else
            pm_queries.sub! /^many Credits is /, ""
            lv_metal = /(Silver|Gold|Iron)/.match(pm_queries)[0]
            pm_queries.sub! /(Silver|Gold|Iron) \?/, ""
            lv_numeral = input(pm_queries, /^\w+ /)
            lv_number = convert_roman(lv_numeral)
            "#{lv_numeral.reduce{|lv_item, lv_total| lv_item += " #{lv_total}"}} #{lv_metal} is #{(@gv_data[lv_metal.to_sym] * lv_number).to_i} Credits"
    end
  end

  def get_value(pm_queries)
    lv_base = /^(\w+ )+(Silver|Gold|Iron)/.match(pm_queries)[0]
    lv_metal = /(Silver|Gold|Iron)/.match(lv_base)[0]
    lv_num = input(lv_base.sub(lv_metal, ""), /\w+ /)
    lv_quantity = convert_roman lv_num
    lv_credits = /\d+/.match(pm_queries.sub(/^(\w+ )+(Silver|Gold|Iron)/, ""))[0]
    @gv_data[lv_metal.to_sym] = lv_credits.to_f / lv_quantity.to_f
  end

  def convert_roman(pm_roman)
        pm_roman.map{|lv_num| @gv_data[lv_num.to_sym][:roman]}.reduce(:+)
        lv_rom = pm_roman.map{|lv_num| @gv_data[lv_num.to_sym][:roman]}.reduce(:+)
        lv_result = to_Decimal lv_rom

  end

  def input(pm_string, pm_regex, pm_array = [])
    if(pm_string =~ pm_regex)
        pm_array << pm_regex.match(pm_string)[0].strip
        input(pm_string.sub(pm_regex, ""), pm_regex, pm_array)
    else
        pm_array
    end
  end

end
