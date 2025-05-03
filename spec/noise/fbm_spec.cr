require "./../spec_helper"
require "../../src/meth/noise/value_noise"
require "../../src/meth/noise/fbm"

describe Meth::FBM do
  include Meth

  test "range with negative values and real numbers" do
    n = FBM.new(ValueNoise.new, scale: 2, octaves: 3)

    Rect2f.new(-43, -67, 19, 11).each_point(0.7, 0.7) { |x, y|
      v = n[x.to_f32, y.to_f32]
      assert v >= -1.0
      assert v <= 1.0
    }
  end
end
