require "./../spec_helper"

describe Meth::Point do
  include Meth

  test "towards" do
    p1 = Point2f.new(1.0, 2.0)
    p2 = Point2f.new(2.0, 2.0)

    assert p1.towards(p2) == Vector2f.new(1.0, 0.0)

    p1 = Point2f.new(1.0, 2.0)
    p2 = Point2f.new(-2.0, -2.0)

    assert p1.towards(p2) == Vector2f.new(-3.0, -4.0)
  end

  test "add" do
    assert Point2f.new(0.0, -1.0) + Vector2f.new(3.1, 4.0) == Point2f.new(3.1, 3.0)
  end

  test "aligned" do
    assert Point2f.new(1.5, 1.5).aligned(4) == Point2i.new(0, 0)
    assert Point2f.new(4.0, 4.0).aligned(4) == Point2i.new(4, 4)
    assert Point2f.new(5.0, 8.0).aligned(4) == Point2i.new(4, 8)

    assert Point2f.new(-1.5, -1.5).aligned(4) == Point2i.new(-4, -4)
    assert Point2f.new(-4.0, -4.0).aligned(4) == Point2i.new(-4, -4)
    assert Point2f.new(-5.0, -8.0).aligned(4) == Point2i.new(-8, -8)
  end
end
