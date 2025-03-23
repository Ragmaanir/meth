require "./noise"
require "open-simplex-noise"

class Meth::OSNWrapper < Meth::Noise
  getter simplex : OpenSimplexNoise

  def initialize(seed : Int64 = 12_345_i64, **options)
    super(**options)
    @simplex = OpenSimplexNoise.new(seed)
  end

  def [](x : Float32, y : Float32) : Float32
    x = x / scale
    y = y / scale

    simplex.generate(x, y).to_f32
  end
end
