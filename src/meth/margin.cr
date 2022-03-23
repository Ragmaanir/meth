module Meth
  struct Margin(Scalar)
    ZERO = new(0, 0, 0, 0)

    # {% for d in ["left", "right", "top", "bottom"] %}
    #   def self.{{d.id}}(v : Scalar)
    #     @{{d.id}} = v
    #   end
    # {% end %}

    def self.left(v : Scalar)
      new(v, 0, 0, 0)
    end

    getter left : Scalar
    getter right : Scalar
    getter top : Scalar
    getter bottom : Scalar

    def initialize(value : Scalar)
      initialize(value, value, value, value)
    end

    def initialize(@left : Scalar, @right : Scalar, @top : Scalar, @bottom : Scalar)
    end

    def dimension
      Dimension2(Scalar).new(left + right, top + bottom)
    end

    def top_left : Vector2(Scalar)
      Vector2(Scalar).new(left, top)
    end

    def bottom_right : Vector2(Scalar)
      Vector2(Scalar).new(right, bottom)
    end
  end
end
