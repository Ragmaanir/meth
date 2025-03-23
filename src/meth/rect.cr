module Meth
  struct Rect2(Scalar)
    include Shape

    getter min : Point2(Scalar)
    getter size : Dimension2(Scalar)

    delegate width, height, to: size

    def initialize(min_x : Scalar, min_y : Scalar, max_x : Scalar, max_y : Scalar)
      # Kontrakt.precondition(min_x < max_x)
      # Kontrakt.precondition(min_y < max_y)
      initialize(point(min_x, min_y), point(max_x, max_y))
    end

    def initialize(@min, max : Point2(Scalar))
      Kontrakt.precondition(min.x <= max.x)
      Kontrakt.precondition(min.y <= max.y)
      @size = Dimension2(Scalar).new(max.x - min.x, max.y - min.y)
    end

    def initialize(@min, @size)
    end

    def initialize(@min, size : Vector2(Scalar))
      @size = size.to_dim
    end

    private def point(x : Scalar, y : Scalar)
      Point2(Scalar).new(x, y)
    end

    private def create(*args)
      self.class.new(*args)
    end

    def positioned(p : Point2(Scalar))
      create(p, size)
    end

    def translated(v : Vector2(Scalar))
      translated(v.x, v.y)
    end

    def translated(x : Scalar, y : Scalar)
      create(
        min.offset(x, y),
        size
      )
    end

    def inset(amount : Scalar)
      create(
        min.offst(amount),
        max.offset(-amount)
      )
    end

    def inset(margin : Margin(Scalar))
      inset(
        margin.left, margin.top,
        margin.right, margin.bottom
      )
    end

    def inset(l : Scalar, r : Scalar, t : Scalar, b : Scalar)
      create(
        min.offset(l, t),
        max.offset(-r, -b)
      )
    end

    def top_left
      min
    end

    def top_right
      point(min.x + width, min.y)
    end

    def bottom_right
      point(min.x + width, min.y + height)
    end

    def max
      bottom_right
    end

    def bottom_left
      point(min.x, min.y + height)
    end

    def top
      min.y
    end

    def bottom
      max.y
    end

    def left
      min.x
    end

    def right
      max.x
    end

    def center
      point(min.x + width / 2, min.y + height / 2)
    end

    def centered
      half = half_size
      self.class.new(
        (-half).to_point,
        half.to_point
      )
    end

    def half_size
      size / 2.0
    end

    def vertices
      {top_left, top_right, bottom_right, bottom_left}
    end

    def contains?(point : Point2(X)) forall X
      point.x >= min.x && point.x < max.x &&
        point.y >= min.y && point.y < max.y
    end

    # FIXME: only for int rect
    def each_horizontally(&)
      (top..bottom).each { |y|
        (left..right).each { |x|
          yield(x, y)
        }
      }
    end

    def to_json(config : JSON::Builder)
      config.object do
        config.field "min", min.to_json(config)
        config.field "size", size.to_json(config)
      end
    end

    def simple_name
      t = Scalar.name.downcase[0]
      "Rect2#{t}"
    end

    def inspect(io : IO)
      io << simple_name
      io << "(min: #{top_left}, max: #{bottom_right})"
    end
  end

  alias Rect2i = Rect2(Int32)
  alias Rect2f = Rect2(Float64)
end
