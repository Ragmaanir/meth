module Meth
  struct Vector2(T)
    getter x : T
    getter y : T

    def self.zero
      new(T.zero, T.zero)
    end

    def self.random
      new(rand(-1.0..1.0), rand(-1.0..1.0)).normalized
    end

    def self.scalar_projection(v : Vector2f, dir : Vector2f) : Float64
      # 1: c = |a| cos(alpha)
      # 2: a*b = |a| |b| cos(alpha)
      # normalize b
      # => a*b = |a| cos(alpha) = c
      v * dir.normalized
    end

    def self.average(vecs : Array(Vector2f))
      vecs.reduce(Vector2f.zero) do |avg, dist|
        if (d2 = dist.square_length) && d2.abs > 0.0
          avg += dist / d2
        else
          avg
        end
      end
    end

    def initialize(v : T)
      initialize(v, v)
    end

    def initialize(@x, @y)
      if x.is_a?(Float64)
        Kontrakt.precondition(!x.as(Float64).nan? && !y.as(Float64).nan?)
      end
    end

    private def create(*args)
      self.class.new(*args)
    end

    def -
      create(-x, -y)
    end

    def *(s : Int32)
      Vector2(T).new(x*s, y*s)
    end

    def *(s : Float64)
      Vector2f.new(x*s, y*s)
    end

    def *(v : self)
      x * v.x + y * v.y
    end

    def /(s : Float64)
      inv = 1.0/s
      create(x*inv, y*inv)
    end

    def -(other : self)
      create(x - other.x, y - other.y)
    end

    def +(other : self)
      create(x + other.x, y + other.y)
    end

    def abs
      create(x.abs, y.abs)
    end

    def zero?
      x.abs.to_f.close_to?(0.0) && y.abs.to_f.close_to?(0.0)
    end

    def normalized
      if zero?
        self
      else
        l = length
        create(x / l, y / l)
      end
    end

    def perpendicular
      create(-y, x)
    end

    def square_length
      x*x + y*y
    end

    def length
      Math.sqrt(square_length)
    end

    def aligned(size : Int32)
      pos = to_vec2f / size.to_f
      Vector2i.new(
        pos.x.floor.to_i * size,
        pos.y.floor.to_i * size
      )
    end

    def close_to?(other : self)
      (other - self).zero?
    end

    def ==(other : self)
      close_to?(other)
    end

    def to_tuple
      {x, y}
    end

    def to_vec2i
      Vector2i.new(x.to_i, y.to_i)
    end

    def to_vec2f
      Vector2f.new(x.to_f, y.to_f)
    end

    def to_point
      Point2(T).new(x, y)
    end

    def to_json(config : JSON::Builder)
      config.object do
        config.field "x", x
        config.field "y", y
      end
    end

    def inspect(io : IO)
      io << "Vector2(#{T})(x: %4.2f, y: %4.2f)" % {x, y}
    end
  end

  alias Vector2i = Vector2(Int32)
  alias Vector2f = Vector2(Float64)
end
