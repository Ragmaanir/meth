require "./../spec_helper"
require "../../src/meth/noise/value_noise"

describe Meth::ValueNoise do
  include Meth
  include StumpyPNG

  # def save_image(name, w, h, &block)
  #   canvas = Canvas.new(w, h)

  #   (0..h - 1).each do |y|
  #     (0..w - 1).each do |x|
  #       canvas[x, y] = yield(x, y)
  #     end
  #   end

  #   StumpyPNG.write(canvas, "spec/noise/#{name}.png")
  # end

  # test "image" do
  #   n = ValueNoise.new

  #   save_image("value_noise_spec", 256, 256) { |x, y|
  #     v = (1 + n[x, y]) / 2 * 255

  #     RGBA.from_rgb_n(v, v, v, 8)
  #   }
  # end

  # test "image from negative values" do
  #   n = ValueNoise.new

  #   save_image("value_noise_spec_negative", 256, 256) { |x, y|
  #     v = (1 + n[x - 100, y - 100]) / 2 * 255

  #     RGBA.from_rgb_n(v, v, v, 8)
  #   }
  # end
  #

  def snapshot(name, rect : Rect2f, resolution = 1, &block)
    w = (rect.width * resolution).to_i
    h = (rect.height * resolution).to_i
    dx = 1 / resolution
    dy = 1 / resolution

    canvas = Canvas.new(w, h)

    rect.each_point(dx, dy) { |x, y, (ix, iy)|
      # skip right and bottom edge points
      if ix < w && iy < h
        canvas[ix, iy] = yield(x, y, {ix, iy})
      end
    }

    StumpyPNG.write(canvas, "spec/noise/#{name}.png")
  end

  test "image" do
    n = ValueNoise.new

    snapshot("value_noise_spec", Rect2f.new(0, 0, 256, 256)) { |x, y|
      v = n.unifloat32(x.to_f32, y.to_f32) * 255

      RGBA.from_rgb_n(v, v, v, 8)
    }
  end

  test "image from negative values" do
    n = ValueNoise.new

    snapshot("value_noise_spec_negative", Rect2f.new(-100, -100, 156, 156)) { |x, y|
      v = n.unifloat32(x.to_f32, y.to_f32) * 255

      RGBA.from_rgb_n(v, v, v, 8)
    }
  end

  test "image two" do
    n = ValueNoise.new

    snapshot("image_two", Rect2f.new(-101, -13, -47, 7), 3) { |x, y|
      v = n.unifloat32(x.to_f32, y.to_f32) * 255

      RGBA.from_rgb_n(v, v, v, 8)
    }
  end
end
