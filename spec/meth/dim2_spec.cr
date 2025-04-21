require "./../spec_helper"

describe Meth::Dim2i do
  include Meth

  test "math" do
    assert (Dim2i.new(10, 33) * 2 + Dim2i.new(2, 1)) == Dim2i.new(22, 67)
  end

  test "flip" do
    assert Dim2i.new(10, 33).flip == Dim2i.new(33, 10)
  end

  test "index_for_coord" do
    d = Dim2i.new(2, 3)

    assert d.index_for_coord({0, 0}) == 0
    assert d.index_for_coord({1, 0}) == 1
    assert d.index_for_coord({0, 1}) == 2
    assert d.index_for_coord({1, 1}) == 3
    assert d.index_for_coord({0, 2}) == 4
    assert d.index_for_coord({1, 2}) == 5

    assert d.index_for_coord({1, 2}) == d.product - 1
  end
end
