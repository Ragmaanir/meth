require "./spec_helper"
require "../src/meth/array_2d"

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

  test "indexing" do
    a = SUT(Int32).new(Dim2i.new(3, 2), 0)

    a[{1, 0}] = 1
    a[{0, 1}] = 2
    a[{2, 1}] = 3

    assert a.array == [0, 1, 0, 2, 0, 3]
  end

  test "map" do
    raw = [
      0, 1, 0,
      2, 0, 3,
    ]

    a = SUT(Int32).new(Dim2i.new(3, 2), raw)

    b = a.map { |coord, v|
      2*v + coord.y
    }

    assert b.array == [
      0, 2, 0,
      5, 1, 7,
    ]
  end

  test "inspect_square" do
    raw = [
      0, 1, 255,
      4, 5, 6,
      9, 9, 9,
    ] of UInt8

    a = Array2D.new(Dim2i.new(3, 3), raw)

    assert a.array == raw

    s = String.build { |io|
      a.inspect_square(io)
    }

    assert s == <<-ARR.lstrip("\n")
      0  1255
      4  5  6
      9  9  9

    ARR
  end
end
