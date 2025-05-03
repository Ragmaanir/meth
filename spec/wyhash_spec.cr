require "./spec_helper"

describe Meth::PRNG::Wyhash do
  include Meth

  # test "int32" do
  #   wh = PRNG::Wyhash.new
  #   10.times { |i|
  #     p wh.bifloat32(-i - 10, -10)
  #   }
  # end

  test "bifloat32" do
    wh = PRNG::Wyhash.new
    r = Random.new

    100.times { |i|
      v = wh.bifloat32(r.next_int, r.next_int)
      assert v >= -1.0 && v <= 1.0
    }
  end

  test "unifloat32" do
    wh = PRNG::Wyhash.new
    r = Random.new

    100.times { |i|
      v = wh.unifloat32(r.next_int, r.next_int)
      assert v >= 0.0 && v <= 1.0
    }
  end

  test "int32 is random in the negative" do
    wh = PRNG::Wyhash.new

    values = 10000.times.map { |i| wh.bifloat32(i, -10) }.to_a

    avg = values.sum / values.size
    var = values.map { |v| (avg - v).abs }.sum

    assert var > 0.1
  end
end
