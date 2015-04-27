CONVERSIONS = [ # <- here we use a constant, could also use a bare word method instead
  [1000, "M"],
  [900, "CM"],
  [500, "D"],
  [400, "CD"],
  [100, "C"],
  [90, "XC"],
  [50, "L"],
  [40, "XL"],
  [10, "X"],
  [9, "IX"],
  [5, "V"], 
  [4, "IV"],
  [1, "I"]
]

def conversion_factors_for(in_arabic) # <- would like to separate the responsibility of looking up the conversion factors from the task of creating the conversion factors themselves
  CONVERSIONS.find { |arabic, _| arabic <= in_arabic }
end

def convert(in_arabic) # <- when working on a small routine, convenient to keep the pieces local, also note this defers making the decision on where to put it
  # return "" if in_arabic.zero? # <- following TPP nil->constant is a simple way of getting this test to pass <- notice the "if clause", or "guard clause"
  # return "I" if in_arabic == 1 # <- nil->constant is a wonderfully simple transformation according to TPP
  # return "V" if in_arabic == 5 # <- nil->constant transformation again
  # "I" + convert(in_arabic - 1) # <- begin with the usual technique of guard clause and returning a constant (following nil->constant transformation), then we will refactor the algorithm
  # 
  # introducing duplication in order to coax the algorithm towards a simpler form
  # however according to the 4 Simple Rules of Design this is a huge violation of "revealing intention", it is crossing abstraction layers
  # i.e. it doesn't stay at a consistent level of abstraction: it is responsible for doing the conversion, however it also drops down into looking up what the actual converstion factors are
  # be sure to consider this when checking code for "done-ness"
  # arabic, roman = [[5, "V"], [1, "I"]].find { |arabic, _| arabic <= in_arabic } # <- use underscore in the find predicate to accentuate the fact that the lookup isn't dependent on the 2nd part of the array
  # roman + convert(in_arabic - arabic)

  return "" if in_arabic.zero?
  arabic, roman = conversion_factors_for(in_arabic) # <- using extract method to give us a named abstraction for what we are doing
  roman + convert(in_arabic - arabic)
end

describe "Converting arabic numbers to roman numerals" do
  context "Romans didn't have a 0" do # <- the degenerate case, corresponding to the {}->nil transformation from the Transformation Priority Premise (TPP)
    it "converts 0 to a blank string" do # <- 0 is an exceptional case that stands outside the normal rules, we want to highlight it separately
      expect(convert(0)).to eq("")
    end
  end

  # it "converts 1 to I" do # <- brings variation to the system after setting up the structure with the degenerate case <- after this, what's the next test? 2 might be considered a vector of 1's, so instead maybe choose a more complex constant like 5
  #   expect(convert(1)).to eq("I")
  # end
  # 
  # it "converts 5 to V" do # <- note that the fact that this test can be created using a simple search-and-replace from the test for 1 accentuates that it is also a test for a constant
  #   expect(convert(5)).to eq("V") # <- when this test fails, we want to reset the test so that we can move from nil instead of from the "I" that is returned from the previous example
  # end

  # according to the 4 Rules of Simple Design, we now have duplication around how to test that we want to eliminate
  # allows us to extract what we are testing from how we are testing it
  { 
    1 => "I",
    2 => "II", # <- we've seen a simple constant, a slightly more complex constant, now we have 2 which can be seen as a vector or array of 1's, according to TPP this is much more complex than a constant or even a scalar
    4 => "IV",
    5 => "V",
    6 => "VI",
    9 => "IX",
    10 => "X",
    11 => "XI",
    14 => "XIV",
    15 => "XV", 
    16 => "XVI", 
    19 => "XIX",
    20 => "XX",
    40 => "XL",
    49 => "XLIX",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    1000 => "M",
    3497 => "MMMCDXCVII"
  }.each_pair {|arabic, roman|
    it "converts #{arabic} to #{roman}" do 
      expect(convert(arabic)).to eq(roman) 
    end
  }
end
