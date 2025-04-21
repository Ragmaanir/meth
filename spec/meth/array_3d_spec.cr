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

  test "indexing" do
    a = SUT(Int32).new(Dim3i.new(3, 2, 2), 0)

    a[{1, 0, 0}] = 1
    a[{0, 1, 0}] = 2
    a[{2, 1, 1}] = 3

    assert a.array == [
      # z=0
      0, 1, 0,
      2, 0, 0,
      # z=1
      0, 0, 0,
      0, 0, 3,
    ]
  end

  test "map" do
    raw = [
      # z=0
      0, 1, 0,
      2, 0, 3,
      # z=1
      0, 0, 0,
      0, 1, 2,
    ]

    a = SUT(Int32).new(Dim3i.new(3, 2, 2), raw)

    b = a.map { |coord, v|
      2*v + coord.y
    }

    assert b.array == [
      # z=0
      0, 2, 0,
      5, 1, 7,
      # z=1
      0, 0, 0,
      1, 3, 5,
    ]
  end
end
