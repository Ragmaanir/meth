module Meth
  class Dimension3(T)
    def self.zero
      new(T.zero, T.zero, T.zero)
    end

    getter width : T
    getter height : T
    getter depth : T

    def_equals_and_hash width, height, depth

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

    def index_for_coord(coord : Tuple(Int32, Int32, Int32))
      coord[0] + coord[1] * width + coord[2] * height*width
    end

    def coord_for_index(i : Int32) : Tuple(Int32, Int32, Int32)
      x = i % width
      y = (i // width) % height
      z = i // (width * height)

      {x, y, z}
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
      Meth.inspect_composite(io, "Dim3", width, height, depth)
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
