require "../spec_helper"
require "../../src/meth/array_3d"

describe Meth::Array3D do
  alias SUT = Meth::Array3D

  test "layout of internal array" do
    a = SUT(Int32).new(Dim3i.new(3, 3, 2), 0)

    v = 1

    a.each do |(coord, _val)|
      a[coord] = v
      v += 1
    end

    assert a.array == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]

    v = 1

    a.each do |(_coord, val)|
      assert val == v
      v += 1
    end
  end
end
