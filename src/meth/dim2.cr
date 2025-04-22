module Meth
  class Dimension2(T)
    def self.zero
      new(T.zero, T.zero)
    end

    getter width : T
    getter height : T

    def_equals_and_hash width, height

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

    def /(v : Vector2(X)) forall X
      Vector2f.new(width / v.x, height / v.y)
    end

    def product
      width * height
    end

    def diagonal
      Vector2(T).new(width, height).length
    end

    def flip : self
      self.class.new(height, width)
    end

    def index_for_coord(coord : Tuple(Int32, Int32))
      coord[0] + coord[1] * width
    end

    def coord_for_index(i : Int32) : Tuple(Int32, Int32)
      x = i % width
      y = i // width

      {x, y}
    end

    # FIXME: only for int dim
    def each_point(&)
      height.times { |y|
        width.times { |x|
          yield(x, y)
        }
      }
    end

    def to_vector
      Vector2(T).new(width, height)
    end

    def to_vector2f
      Vector2(Float64).new(width.to_f, height.to_f)
    end

    # def to_dim
    #   # FIXME: determine statically?
    #   if x.is_a?(Int32)
    #     Dim2i.new(x.to_i, y.to_i)
    #   else
    #     Dim2f.new(x.to_f, y.to_f)
    #   end
    # end

    def to_dim : Dimension2(Scalar)
      # FIXME: determine statically?
      {% if @type.is_a?(Int32) %}
        Dim2i.new(x.to_i, y.to_i)
      {% else %}
        Dim2f.new(x.to_f, y.to_f)
      {% end %}
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
      Meth.inspect_composite(io, "Dim2", width, height)
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
end
