module Meth
  class Circle2
    include Shape

    alias Scalar = Float64
    alias Point = Point2(Scalar)

    getter center : Point
    getter radius : Scalar

    def initialize(@center : Point, @radius : Scalar)
      Kontrakt.precondition(radius > 0.0)
    end

    private def point(x : Scalar, y : Scalar)
      Point2(Scalar).new(x, y)
    end

    def translated(v : Vector2(Scalar))
      translated(v.x, v.y)
    end

    def translated(x : Scalar, y : Scalar)
      self.class.new(point(center.x + x, center.y + y), radius)
    end

    def diameter
      radius * 2
    end

    def bounding_box : Rect2f
      v = Vector2(Scalar).new(radius, radius)

      Rect2f.new(center - v, center + v)
    end

    def contains?(point : Point)
      (point - center).length <= radius
    end

    def to_json(json : JSON::Builder)
      json.object do
        json.field "center" do
          center.to_json(json)
        end

        json.field "radius" do
          radius.to_json(json)
        end
      end
    end
  end # Circle2
end
