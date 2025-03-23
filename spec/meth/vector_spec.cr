require "./../spec_helper"

describe Meth::Vector do
  include Meth

  test "normalized" do
    assert v2f(72.08720551427966, 0.2222694816026665).normalized.length.close_to?(1.0)
    assert v2f(52.6059789739017, 0.0011233645641495207).normalized.length.close_to?(1.0)
    assert v2f(1.0, -4.0).normalized.length.close_to?(1.0)

    10.times do
      x = rand(0.0..100.0)
      y = rand
      assert v2f(x, y).normalized.length.close_to?(1.0)
    end
  end

  test "add" do
    assert v2f(0.0, -1.0) + v2f(3.1, 4.0) == v2f(3.1, 3.0)
  end

  test "divide" do
    assert (v2f(4.2, -1.5) / 2.0) == v2f(2.1, -0.75)
    assert (v2f(-4.2, 1.5) / 2.0) == v2f(-2.1, 0.75)
  end

  test "floored divide" do
    assert (v2f(1.0, -1.0) // 2.0) == v2f(0.0, -1.0)
    assert (v2f(4.0, -0.1) // 2.0) == v2f(2.0, -1.0)

    assert (v2f(1.0, -1.0) // 2) == v2i(0, -1)
    assert (v2f(0.0, -4.1) // 2) == v2i(0, -3)
  end

  test "close_to" do
    # assert v2f(0.0, 0.0).close_to?(v2f(EPSILON_64, 2*EPSILON_64))
    # assert !v2f(0.0, 0.0).close_to?(v2f(0.0, 3*EPSILON_64))
    assert v2f(0.0, 0.0).close_to?(v2f(Float64::EPSILON, 2*Float64::EPSILON))
    assert !v2f(0.0, 0.0).close_to?(v2f(0.0, 3*Float64::EPSILON))
  end

  test "aligned" do
    assert v2f(1.5, 1.5).aligned(4).close_to?(v2i(0, 0))
    assert v2f(4.0, 4.0).aligned(4).close_to?(v2i(4, 4))
    assert v2f(5.0, 8.0).aligned(4).close_to?(v2i(4, 8))

    assert v2f(-1.5, -1.5).aligned(4).close_to?(v2i(-4, -4))
    assert v2f(-4.0, -4.0).aligned(4).close_to?(v2i(-4, -4))
    assert v2f(-5.0, -8.0).aligned(4).close_to?(v2i(-8, -8))
  end

  test "scalar_projection with zero" do
    a = v2f(0.0, 0.0)
    b = v2f(0.0, 0.0)

    assert Vector2f.scalar_projection(a, b).close_to? 0.0
  end

  test "scalar_projection on x and y" do
    a = v2f(2.0, 3.0)
    x = v2f(1.0, 0.0)
    y = v2f(0.0, 1.0)

    assert Vector2f.scalar_projection(a, x).close_to? 2.0
    assert Vector2f.scalar_projection(a, y).close_to? 3.0
  end

  test "scalar_projection on diagonal" do
    a = v2f(1.0, 2.0)
    diag = v2f(1.0, 1.0)

    # assert Vector2f.scalar_projection(a, diag).close_to?(1.5 * diag.length, 8 * EPSILON_64)
    assert Vector2f.scalar_projection(a, diag).close_to?(1.5 * diag.length, 8 * Float64::EPSILON)
  end
end
