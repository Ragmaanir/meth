require "./spec_helper"

describe Meth::Point do
  include Meth

  test "towards" do
    p1 = p2f(1.0, 2.0)
    p2 = p2f(2.0, 2.0)

    assert p1.towards(p2) == v2f(1.0, 0.0)

    p1 = p2f(1.0, 2.0)
    p2 = p2f(-2.0, -2.0)

    assert p1.towards(p2) == v2f(-3.0, -4.0)
  end

  test "add" do
    assert p2f(0.0, -1.0) + v2f(3.1, 4.0) == p2f(3.1, 3.0)
  end

  test "mul" do
    assert (p2i(1, 2) * v2f(1.1, 2.9)) == p2f(1.1, 5.8)
  end

  test "divide with scalar" do
    assert (p2f(1.0, 2.0) / 2.0) == p2f(0.5, 1.0)
  end

  test "divide with vector" do
    assert (p2f(1.0, 2.0) / v2f(1.0, 2.0)) == p2f(1.0, 1.0)
    assert (p2f(8.1, -3.6) / v2f(9.0, -6.0)).close_to?(p2f(0.9, 0.6))
  end

  test "floored divide" do
    assert (p2f(4.2, -1.5) // 2) == p2i(2, -1)
    assert (p2f(-4.2, 1.5) // 2) == p2i(-3, 0)
  end

  test "aligned" do
    assert p2f(1.5, 1.5).aligned(4) == p2i(0, 0)
    assert p2f(4.0, 4.0).aligned(4) == p2i(4, 4)
    assert p2f(5.0, 8.0).aligned(4) == p2i(4, 8)

    assert p2f(-1.5, -1.5).aligned(4) == p2i(-4, -4)
    assert p2f(-4.0, -4.0).aligned(4) == p2i(-4, -4)
    assert p2f(-5.0, -8.0).aligned(4) == p2i(-8, -8)
  end
end
