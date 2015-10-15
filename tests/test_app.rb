require './lib/conversionrules.rb'
require 'test/unit'
require 'rack/test'


class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_1
    @lv_conversion_rules = ConversionRules.new
    @lv_conversion_rules.insert_queries "glob is I"
    @lv_conversion_rules.insert_queries "prok is V"
    @lv_conversion_rules.insert_queries "pish is X"
    @lv_conversion_rules.insert_queries "tegj is L"
    @lv_conversion_rules.insert_queries "glob glob Silver is 34 Credits"
    @lv_conversion_rules.insert_queries "glob prok Gold is 57800 Credits"
    @lv_conversion_rules.insert_queries "pish pish Iron is 3910 Credits"

    @lv_conversion_rules.insert_queries "how much is pish tegj glob glob ?"
    lv_result = @lv_conversion_rules.launch
    assert_match( /pish tegj glob glob is 42/, lv_result)

    @lv_conversion_rules.insert_queries "how many Credits is glob prok Silver ?"
    lv_result = @lv_conversion_rules.launch
    assert_match( /glob prok Silver is 68 Credits/, lv_result)

    @lv_conversion_rules.insert_queries "how many Credits is glob prok Gold ?"
    lv_result = @lv_conversion_rules.launch
    assert_match( /glob prok Gold is 57800 Credits/, lv_result)

    @lv_conversion_rules.insert_queries "how many Credits is glob prok Iron ?"
    lv_result = @lv_conversion_rules.launch
    assert_match( /glob prok Iron is 782 Credits/, lv_result)

    @lv_conversion_rules.insert_queries "how much wood could a woodchuck chuck if a woodchuck could chuck wood ?"
    lv_result = @lv_conversion_rules.launch
    assert_match( /I have no idea what you are talking about/, lv_result)

  end
end
