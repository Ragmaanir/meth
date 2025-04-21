require "../array_2d"

module Meth::NoiseMath
  def lerp(a : Float32, b : Float32, t : Float32) : Float32
    a + (b - a) * t
  end

  def bilinear_interp(
    x : Float32, y : Float32,
    v00 : Float32, v10 : Float32,
    v01 : Float32, v11 : Float32,
  ) : Float32
    lerp(
      lerp(v00, v10, x), # Interpolate along x at y=0
      lerp(v01, v11, x), # Interpolate along x at y=1
      y                  # Interpolate between the results along y
    )
  end
end

abstract class Meth::Noise
  include NoiseMath

  getter scale : Float32

  def initialize(scale : Int32 | Float32 = 1.0)
    @scale = scale.to_f32
  end

  def [](p : Point2i) : Float32
    self[p.x, p.y]
  end

  def [](p : Point2f) : Float32
    self[p.x.to_f32, p.y.to_f32]
  end

  def [](x : Int32, y : Int32) : Float32
    self[x.to_f32, y.to_f32]
  end

  abstract def [](x : Float32, y : Float32) : Float32

  def matrix(origin : Point2i, size : Dim2i) : Array2D(Float32)
    res = Array2D(Float32).new(size) { |at|
      self[origin.to_point2f + Vector2f.new(at.x, at.y)]
    }
  end
end
