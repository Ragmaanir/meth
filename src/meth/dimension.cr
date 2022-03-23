module Meth
  struct Dimension2(T)
    def self.zero
      new(T.zero, T.zero)
    end

    getter width : T
    getter height : T

    def initialize(@width, @height)
    end

    def x
      width
    end

    def y
      height
    end

    def +(other : self)
      self.class.new(width + other.width, height + other.height)
    end

    def *(factor : T)
      self.class.new(factor * width, factor * height)
    end

    def /(factor : T)
      self.class.new(width / factor, height / factor)
    end

    def *(v : Vector2(X)) forall X
      self.class.new(width * v.x, height * v.y)
    end

    def product
      width * height
    end

    def diagonal
      Vector2(T).new(width, height).length
    end

    def to_vector
      Vector2(T).new(width, height)
    end

    def to_vector2f
      Vector2(Float64).new(width.to_f, height.to_f)
    end

    def to_tuple
      {width, height}
    end

    def to_s(io : IO)
      stringify(io)
    end

    def inspect(io : IO)
      stringify(io)
    end

    private def stringify(io : IO)
      t = T.to_s.downcase[0]
      io << "Dim2#{t}(#{width},#{height})"
    end

    def to_json(config : JSON::Builder)
      config.object do
        config.field "width", width
        config.field "height", height
      end
    end
  end

  alias Dim2i = Dimension2(Int32)
  alias Dim2f = Dimension2(Float64)

  class Dimension3(T)
    getter width : T
    getter height : T
    getter depth : T

    def initialize(@width, @height, @depth)
    end

    def +(other : self)
      self.class.new(width + other.width, height + other.height, depth + other.depth)
    end

    def *(factor : T)
      self.class.new(factor * width, factor * height, factor * depth)
    end

    def /(factor : T)
      self.class.new(width / factor, height / factor, depth / factor)
    end

    def *(v : Vector3(X)) forall X
      self.class.new(width * v.x, height * v.y, depth * v.z)
    end

    def product
      width * height * depth
    end

    def diagonal
      Vector3(T).new(width, height, depth).length
    end

    def to_vector
      Vector3(T).new(width, height, depth)
    end

    def to_tuple
      {width, height, depth}
    end

    def to_s(io : IO)
      stringify(io)
    end

    def inspect(io : IO)
      stringify(io)
    end

    private def stringify(io : IO)
      t = T.to_s.downcase[0..1]
      io << "Dim3#{t}(#{width},#{height},#{depth})"
    end

    def to_json(config : JSON::Builder)
      config.object do
        config.field "width", width
        config.field "height", height
        config.field "depth", depth
      end
    end
  end

  alias Dim3i = Dimension3(Int32)
  alias Dim3f = Dimension3(Float64)
end
