require "./spec_helper"

describe Meth::Dim3i do
  include Meth

  test "math" do
    assert (Dim3i.new(1, 2, 1) * 2 + Dim3i.new(2, 1, 4)) == Dim3i.new(4, 5, 6)
  end

  test "index_for_coord" do
    d = Dim3i.new(2, 3, 2)

    assert d.index_for_coord({0, 0, 0}) == 0
    assert d.index_for_coord({1, 0, 0}) == 1
    assert d.index_for_coord({0, 1, 0}) == 2
    assert d.index_for_coord({1, 1, 0}) == 3
    assert d.index_for_coord({0, 2, 0}) == 4
    assert d.index_for_coord({1, 2, 0}) == 5

    assert d.index_for_coord({0, 0, 1}) == 6
    assert d.index_for_coord({1, 0, 1}) == 7
    assert d.index_for_coord({0, 1, 1}) == 8
    assert d.index_for_coord({1, 1, 1}) == 9
    assert d.index_for_coord({0, 2, 1}) == 10
    assert d.index_for_coord({1, 2, 1}) == 11

    assert d.index_for_coord({1, 2, 1}) == d.product - 1
  end
end
