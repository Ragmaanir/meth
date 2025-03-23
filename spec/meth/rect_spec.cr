require "./../spec_helper"

describe Meth::Rect do
  include Meth

  TESTER = DefaultIntersectionTester.new

  test "intersects" do
    r1 = Rect2f.new(p2f(0.0, 0.0), p2f(1.0, 1.0))
    r2 = Rect2f.new(p2f(0.0, 0.0), p2f(1.0, 1.0))

    assert TESTER.intersects?(r1, r2)
    assert TESTER.intersects?(r2, r1)

    r1 = Rect2f.new(p2f(0.0, 0.0), p2f(1.0, 1.0))
    r2 = Rect2f.new(p2f(0.5, 0.5), p2f(2.0, 2.0))

    assert TESTER.intersects?(r1, r2)
    assert TESTER.intersects?(r2, r1)
  end

  test "does not intersect" do
    r1 = Rect2f.new(p2f(0.0, 0.0), p2f(1.0, 1.0))
    r2 = Rect2f.new(p2f(2.0, 2.0), p2f(3.0, 3.0))

    assert !TESTER.intersects?(r1, r2)
    assert !TESTER.intersects?(r2, r1)

    r1 = Rect2f.new(p2f(0.0, 0.0), p2f(1.0, 1.0))
    r2 = Rect2f.new(p2f(1.1, 1.1), p2f(10.0, 10.0))

    assert !TESTER.intersects?(r1, r2)
    assert !TESTER.intersects?(r2, r1)
  end

  test "center" do
    assert Rect2f.new(p2f(0.0, 0.0), p2f(1.0, 1.0)).center == p2f(0.5, 0.5)
  end

  test "inset" do
    o = Rect2i.new(p2i(0, 0), p2i(100, 100))

    r = o.inset(10, 10, 10, 10)

    assert r.min == p2i(10, 10)
    assert r.max == p2i(90, 90)
  end

  test "inset with zero size rect" do
    o = Rect2i.new(p2i(0, 0), p2i(0, 0))

    r = o.inset(0, 0, 0, 0)

    assert r.min == p2i(0, 0)
    assert r.max == p2i(0, 0)
  end

  test "inset creating negative size raises"
end
