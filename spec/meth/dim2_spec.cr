require "./../spec_helper"

describe Meth::Dim2i do
  include Meth

  test "math" do
    assert (Dim2i.new(10, 33) * 2 + Dim2i.new(2, 1)) == Dim2i.new(22, 67)
  end

  test "flip" do
    assert Dim2i.new(10, 33).flip == Dim2i.new(33, 10)
  end
end
