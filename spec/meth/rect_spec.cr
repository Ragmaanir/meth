require "./../spec_helper"

describe Meth::Rect do
  include Meth

  TESTER = DefaultIntersectionTester.new

  test "intersects" do
    r1 = Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(1.0, 1.0))
    r2 = Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(1.0, 1.0))

    assert TESTER.intersects?(r1, r2)
    assert TESTER.intersects?(r2, r1)

    r1 = Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(1.0, 1.0))
    r2 = Rect2f.new(Point2f.new(0.5, 0.5), Point2f.new(2.0, 2.0))

    assert TESTER.intersects?(r1, r2)
    assert TESTER.intersects?(r2, r1)
  end

  test "does not intersect" do
    r1 = Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(1.0, 1.0))
    r2 = Rect2f.new(Point2f.new(2.0, 2.0), Point2f.new(3.0, 3.0))

    assert !TESTER.intersects?(r1, r2)
    assert !TESTER.intersects?(r2, r1)

    r1 = Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(1.0, 1.0))
    r2 = Rect2f.new(Point2f.new(1.1, 1.1), Point2f.new(10.0, 10.0))

    assert !TESTER.intersects?(r1, r2)
    assert !TESTER.intersects?(r2, r1)
  end

  test "center" do
    assert Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(1.0, 1.0)).center == Point2f.new(0.5, 0.5)
  end

  test "inset" do
    o = Rect2i.new(Point2i.new(0, 0), Point2i.new(100, 100))

    r = o.inset(10, 10, 10, 10)

    assert r.min == Point2i.new(10, 10)
    assert r.max == Point2i.new(90, 90)
  end

  test "inset with zero size rect" do
    o = Rect2i.new(Point2i.new(0, 0), Point2i.new(0, 0))

    r = o.inset(0, 0, 0, 0)

    assert r.min == Point2i.new(0, 0)
    assert r.max == Point2i.new(0, 0)
  end
end
