require "./noise"
require "./../prng"

class Meth::ValueNoise < Meth::Noise
  getter gen : Meth::PRNG::Noise2D

  def initialize(@gen = Meth::PRNG::Wyhash.new, **options)
    super(**options)
  end

  def [](x : Float32, y : Float32) : Float32
    x = x / scale
    y = y / scale

    xu = x.to_u!
    yu = y.to_u!

    # v = gen.unifloat32(xu, yu)

    v00 = gen.bifloat32(xu, yu)
    v10 = gen.bifloat32(xu + 1, yu)
    v11 = gen.bifloat32(xu + 1, yu + 1)
    v01 = gen.bifloat32(xu, yu + 1)

    dx = x - xu
    dy = y - yu

    v = bilinear_interp(dx, dy, v00, v10, v01, v11)

    # d00 = dx*dx + dy*dy
    # d10 = (1 - dx)*(1 - dx) + dy*dy
    # d11 = (1 - dx)*(1 - dx) + (1 - dy)*(1 - dy)
    # d01 = dx*dx + (1 - dy)*(1 - dy)

    # sum = 2*(v00 + v10 + v11 + v01)
    # interp = (d00 * v00 + d10 * v10 + d11 * v11 + d01 * v01)
    # v = interp / sum

    # v = v > 0.35 ? 1 : 0

    # (255 * v).to_u8
    v
  end
end
