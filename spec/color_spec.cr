require "./spec_helper"

describe Meth::Color do
  include Meth

  test "constructor" do
    c1 = Color.new(200, 0, 0)

    assert c1.r == 200
    assert c1.g == 0
    assert c1.b == 0
    assert c1.a == 255
  end

  test "override with index" do
    c = Color.new(150, 0, 0)
    o = c.override(0, 123_u8)

    assert o.r == 123
    assert o.g == 0
  end
end
