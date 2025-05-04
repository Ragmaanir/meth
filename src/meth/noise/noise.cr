require "../array_2d"
require "../interpolation"

enum Meth::Polarity
  Uni
  Bi
end

abstract class Meth::Noise
  include Interpolation

  getter scale : Float32

  def initialize(scale : Int32 | Float32 = 1.0)
    @scale = scale.to_f32
  end

  def bi_to_uni(v : Float32) : Float32
    (1 + v) / 2
  end

  def bi_to_uni(v : Float64) : Float64
    (1 + v) / 2
  end

  def polarize(v : Float, polarize_to : Polarity)
    case polarize_to
    in Polarity::Bi  then v
    in Polarity::Uni then bi_to_uni(v)
    end
  end

  def [](p : Point2i, polarize_to : Polarity = :bi) : Float32
    self[p.x, p.y, polarize_to]
  end

  def [](p : Point2f, polarize_to : Polarity = :bi) : Float32
    self[p.x.to_f32, p.y.to_f32, polarize_to]
  end

  def [](x : Int32, y : Int32, polarize_to : Polarity = :bi) : Float32
    self[x.to_f32, y.to_f32, polarize_to]
  end

  abstract def [](x : Float32, y : Float32, polarize_to : Polarity = :bi) : Float32

  def matrix(origin : Point2i, size : Dim2i, polarize_to : Polarity = :bi) : Array2D(Float32)
    Array2D(Float32).new(size) { |at|
      self[origin.to_point2f + Vector2f.new(at.x, at.y), polarize_to]
    }
  end
end
