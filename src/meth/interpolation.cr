module Meth::Interpolation
  def lerp(a : Float32, b : Float32, t : Float32) : Float32
    a + (b - a) * t
  end

  def bilerp(
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
