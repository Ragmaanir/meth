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

  test "inset creating negative size creates empty rect preserving position" do
    # does nothing if no space
    r = Rect2i.new(p2i(5, 7), d2i(0, 0)).inset(1)

    assert r == Rect2i.new(p2i(5, 7), d2i(0, 0))

    # insets right, but not left
    r = Rect2i.new(p2i(5, 7), d2i(1, 0)).inset(1)

    assert r == Rect2i.new(p2i(5, 7), d2i(0, 0))

    # insets left and right
    r = Rect2i.new(p2i(5, 7), d2i(2, 0)).inset(1)

    assert r == Rect2i.new(p2i(6, 7), d2i(0, 0))
  end

  test "points" do
    a = Rect2i.new(Point2i.new(2, 1), Point2i.new(4, 2))

    assert a.points == [
      {2, 1}, {3, 1}, {4, 1},
      {2, 2}, {3, 2}, {4, 2},
    ].map { |t| Point2i.new(t[0], t[1]) }

    b = Rect2i.new(Point2i.new(-1, -1), Point2i.new(1, 0))

    assert b.points == [
      {-1, -1}, {0, -1}, {1, -1},
      {-1, 0}, {0, 0}, {1, 0},
    ].map { |t| Point2i.new(t[0], t[1]) }
  end

  test "each_point" do
    points = [] of Tuple(Int32, Int32)

    Rect2i.new(Point2i.new(2, 1), Point2i.new(4, 2)).each_point { |x, y|
      points << {x, y}
    }

    assert points == [
      {2, 1}, {3, 1}, {4, 1},
      {2, 2}, {3, 2}, {4, 2},
    ]
  end
end
