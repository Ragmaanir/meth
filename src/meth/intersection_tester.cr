module Meth
  struct Intersection
    getter at : Point2f
    getter depth : Float64 # FIXME: add normal of intersection

    def initialize(@at, @depth)
    end
  end

  abstract class IntersectionTester
    abstract def intersection(a : Shape, b : Shape)
  end

  class DefaultIntersectionTester < IntersectionTester
    def intersection(a : Shape, b : Shape) : Intersection?
      # TODO double dispatch?
      case a
      when Rect2   then intersection_distinguished(a, b)
      when Circle2 then intersection_distinguished(a, b)
      else              raise "BUG: shape intersection not implemented"
      end
    end

    def intersection_distinguished(a : Rect2, b : Shape) : Intersection?
      case b
      when Rect2   then intersection_impl(a, b)
      when Circle2 then intersection_impl(a, b)
      else              raise "BUG: shape intersection not implemented"
      end
    end

    def intersection_distinguished(a : Circle2, b : Shape) : Intersection?
      case b
      when Rect2   then intersection_impl(b, a)
      when Circle2 then intersection_impl(a, b)
      else              raise "BUG: shape intersection not implemented"
      end
    end

    def intersects?(a : Shape, b : Shape)
      intersection(a, b) != nil
    end

    def intersection_impl(a : Rect2, b : Rect2) : Intersection?
      maxdist = (a.size / 2.0 + b.size / 2.0).to_vector

      dist = b.center - a.center

      if dist.x.abs < maxdist.x && dist.y.abs < maxdist.y
        at = a.center + dist / 2.0
        Intersection.new(at, dist.length)
      end
    end

    def intersection_impl(rect : Rect2, circle : Circle2) : Intersection?
      # https://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
      dist = (rect.center - circle.center).abs
      hs = rect.half_size

      res = if (dist.x > (hs.x + circle.radius))
              false
            elsif (dist.y > (hs.y + circle.radius))
              false
            elsif (dist.x <= hs.x)
              true
            elsif (dist.y <= hs.y)
              true
            else
              corner_sq = (dist.x - hs.x) ** 2 + (dist.y - hs.y) ** 2

              corner_sq <= circle.radius ** 2
            end

      if res
        Intersection.new(rect.center, dist.length / 2.0) # FIXME dummy solution
      end
    end

    # def intersection_impl(rect : Rect2, circle : Circle2) : Intersection?
    #   center = rect.center
    #   axis = rect.center - circle.center

    #   # Project each edge point of rect onto axis defined by distance vector,
    #   # then check each edge point for inclusion in circle.

    #   # FIXME find_first or so?
    #   rect.vertices.each { |v|
    #     v = v - center
    #     scalar = Vector2f.scalar_projection(v, axis)

    #     point = center + axis * scalar

    #     if circle.contains?(point)
    #       return Intersection.new(point, (circle.center - point).length)
    #     end
    #   }
    # end

    def intersection_impl(a : Circle2, b : Circle2) : Intersection?
      dist = a.center - b.center
      rad_sum = a.radius + b.radius

      if dist.length < rad_sum
        at = a.center + dist / 2.0
        Intersection.new(at, rad_sum - dist.length)
      end
    end
  end
end
