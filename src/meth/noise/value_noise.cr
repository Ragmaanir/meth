require "./noise"
require "./../prng"

class Meth::ValueNoise < Meth::Noise
  enum Interpolation
    None
    Bilinear
    WeightedBilinear
    Circular
  end

  getter noise : Meth::PRNG::Noise2D
  getter interpolation : Interpolation

  def initialize(@noise = Meth::PRNG::Wyhash.new, @interpolation = :bilinear, **options)
    super(**options)
  end

  def [](x : Float32, y : Float32) : Float32
    x = x / scale
    y = y / scale

    xu = x.floor.to_i!
    yu = y.floor.to_i!

    if interpolation == Interpolation::None
      v = noise.bifloat32(xu, yu)
    elsif interpolation == Interpolation::Circular
      raise "Not implemented"
    else
      # OPTIMIZE: cache values
      v00 = noise.bifloat32(xu, yu)
      v10 = noise.bifloat32(xu + 1, yu)
      v11 = noise.bifloat32(xu + 1, yu + 1)
      v01 = noise.bifloat32(xu, yu + 1)

      dx = (x - xu)
      dy = (y - yu)

      case interpolation
      when Interpolation::Bilinear
        v = bilinear_interp(dx, dy, v00, v10, v01, v11)
      when Interpolation::WeightedBilinear
        d00 = (dx*dx + dy*dy) / 2.0_f32
        d10 = ((1 - dx)*(1 - dx) + dy*dy) / 2.0_f32
        d11 = ((1 - dx)*(1 - dx) + (1 - dy)*(1 - dy)) / 2.0_f32
        d01 = (dx*dx + (1 - dy)*(1 - dy)) / 2.0_f32

        sum = {v00, v10, v11, v01}.map(&.abs).sum
        interp = (d00 * v00 + d10 * v10 + d11 * v11 + d01 * v01)
        v = interp / sum
        # if (v > 1 || v < -1)
        #   p [d00, d10, d11, d01]
        #   p [v00, v10, v11, v01]
        #   puts "interp: #{interp}, sum: #{sum}"
        # end
        # Kontrakt.precondition(v >= -1 && v <= 1)
      else
        raise "Bug"
      end
    end

    v
  end
end
