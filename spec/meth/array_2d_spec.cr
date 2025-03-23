require "../spec_helper"
require "../../src/meth/array_2d"

describe Meth::Array2D do
  alias SUT = Meth::Array2D

  test "layout of internal array" do
    a = SUT(Int32).new(Dim2i.new(3, 2), 0)

    v = 1

    a.each do |(coord, _val)|
      a[coord] = v
      v += 1
    end

    assert a.array == [1, 2, 3, 4, 5, 6]

    v = 1

    a.each do |(_coord, val)|
      assert val == v
      v += 1
    end
  end
end
