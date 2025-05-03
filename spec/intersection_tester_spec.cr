describe Meth::IntersectionTester do
  include Meth

  alias SUT = DefaultIntersectionTester

  # FIXME: should they intersect when touching?
  test "rect and rect do NOT intersect when touching" do
    t = SUT.new

    a = Rect2f.new(Point2f.new(0.0, 0.0), Point2f.new(8.0, 8.0))
    b = Rect2f.new(Point2f.new(8.0, 0.0), Point2f.new(10.0, 10.0))

    assert !t.intersects?(a, b)

    b = Rect2f.new(Point2f.new(7.0, 0.0), Point2f.new(10.0, 10.0))

    assert t.intersects?(a, b)
  end
end
