class RomanToDecimal

 # Let's use class method than instance method Ruby world :-)
#  class << self

    def to_Decimal(roman)

      @data = [
        ["M" , 1000],
        ["CM" , 900],
        ["D" , 500],
        ["CD" , 400],
        ["CCC", 300],
        ["CC", 200],
        ["C" , 100],
        ["XC" , 90],
        ["L" , 50],
        ["XL" , 40],
        ["X" , 10],
        ["IX" , 9],
        ["V" , 5],
        ["IV" , 4],
        ["I" , 1]
      ]

      arabic = 0
      for key, value in @data
        while roman.index(key) == 0
          arabic += value
          roman.slice!(key)
        end
      end
      arabic
    end
#  end
end