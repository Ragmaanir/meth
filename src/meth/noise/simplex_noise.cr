require "open-simplex-noise"

module Meth
  class SimplexNoise
    getter simplex : OpenSimplexNoise

    def initialize(seed : Int64 = 12_345_i64)
      @simplex = OpenSimplexNoise.new(seed)
    end

    def [](x : Float64, y : Float64)
      simplex.generate(x, y)
    end

    def [](point : Point2f | Vector2f)
      simplex.generate(point.x, point.y)
    end

    @[Deprecated]
    def noise(point : Point2f, octaves : Array({Float64, Float64}))
      amplitude_sum = octaves.map { |(_, amplitude)| amplitude }.sum

      sum = octaves.map do |(scale, amplitude)|
        amplitude * self[point.x * scale, point.y * scale]
      end.sum

      result = sum / amplitude_sum

      Kontrakt.precondition(result >= -1.0 && result <= 1.0)

      result
    end

    @[Deprecated]
    def noise_ratio(point : Point2f | Vector2f)
      (1 + self[point.x, point.y]) / 2.0
    end

    @[Deprecated]
    def noise_ratio(point : Point2f, octaves : Array({Float64, Float64}))
      amplitude_sum = octaves.map { |(_, amplitude)| amplitude }.sum

      sum = octaves.map do |(scale, amplitude)|
        amplitude * self[point.x * scale, point.y * scale]
      end.sum

      result = (amplitude_sum + sum) / (2*amplitude_sum)

      Kontrakt.precondition(result >= 0.0 && result <= 1.0)

      result
    end
  end
end
