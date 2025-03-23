require "./noise"

class Meth::FBM < Meth::Noise
  getter noise : Noise
  getter octaves : UInt32
  getter lacunarity : Float32
  getter persistence : Float32

  def initialize(@noise, @octaves = 3, @lacunarity = 2.0, @persistence = 0.5, **options)
    super(**options)
  end

  def [](x : Float32, y : Float32) : Float32
    x = x / scale
    y = y / scale

    total = 0
    freq = 1.0_f32
    amp = 1.0_f32
    max_value = 0_f32 # Normalization factor

    octaves.times {
      total += noise[x * freq, y * freq] * amp
      max_value += amp
      freq *= lacunarity
      amp *= persistence
    }

    total / max_value
  end
end
