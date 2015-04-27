def my_sort(numbers_array)
  return numbers_array if numbers_array.size < 2
  less_than_array = []
  greater_than_array = []
  middle_element_index = numbers_array.size / 2
  middle_element = numbers_array[middle_element_index]
  i = 0
  while i < numbers_array.size
    unless i == middle_element_index
      numbers_array[i] <= middle_element ? less_than_array << numbers_array[i] : greater_than_array << numbers_array[i]
    end
    i += 1
  end
  results_array = less_than_array + [middle_element] + greater_than_array
  return results_array if array_is_sorted?(results_array)
  my_sort(results_array)
end

def array_is_sorted?(numbers_array)
  i = 1
  while i < numbers_array.size
    return false if numbers_array[i - 1] > numbers_array[i]
    i += 1
  end
  true
end

describe "Sort an array of numbers using my_sort(numbers_array)" do
  context "using an array of size 3 or less that is already sorted" do
    [ [],
      [0],
      [0, 1],
      [-1, 0],
      [-1, 1],
      [-1, 0, 1]
    ].each { |sorted_array|
      it "should return the same array when given #{sorted_array}" do
        expect(my_sort(sorted_array)).to eq(sorted_array)
      end
    }
  end

  context "using an array of size 2 that is not sorted" do
    [ [1, 0],
      [0, -1],
      [1, -1]
    ].each { |unsorted_array|
      it "should return the two elements swapped when given #{unsorted_array}" do
        expect(my_sort(unsorted_array)).to eq([unsorted_array[1], unsorted_array[0]])
      end
    }
  end

  context "using an array of size 3 that is not sorted" do
    [ 
      [1, 0, -1],
      [0, -1, 1],
      [-1, 1, 0],
      # [0, 1, -1],
      [1, -1, 0]
    ].each { |unsorted_array|
      it "should return [-1, 0, 1] when given #{unsorted_array}" do
        expect(my_sort(unsorted_array)).to eq([-1, 0, 1])
      end
    } 
  end

  it "should return [-2, -1, 0, 1, 2] when given [-1, 1, 0, -2, 2]" do
    expect(my_sort([-1, 1, 0, -2, 2])).to eq([-2, -1, 0, 1, 2])
  end
end
