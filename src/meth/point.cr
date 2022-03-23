module Meth
  struct Point2(T)
    def self.zero
      new(T.zero, T.zero)
    end

    getter x : T
    getter y : T

    def initialize(v : T)
      initialize(v, v)
    end

    def initialize(@x, @y)
      if x.is_a?(Float64)
        Kontrakt.precondition(!x.as(Float64).nan? && !y.as(Float64).nan?)
      end
    end

    def +(v : Vector2(X)) forall X
      self.class.new(x + v.x, y + v.y)
    end

    def -(v : Vector2(X)) forall X
      self + Vector2(X).new(-v.x, -v.y)
    end

    def -(p : self) : Vector2(T)
      Vector2(T).new(x - p.x, y - p.y)
    end

    def *(v : Vector2(X)) forall X
      self.class.new(x * v.x, y * v.y)
    end

    def towards(target : self)
      target - self
    end

    def scale(f : T)
      self.class.new(x*f, y*f)
    end

    def scale(f : Float64)
      Point2f.new(x*f, y*f)
    end

    def offset(ox : T, oy : T) : self
      Point2(T).new(x + ox, y + oy)
    end

    def offset(p : Point2(T)) : self
      Point2(T).new(x + p.x, y + p.y)
    end

    def aligned(size : Int32)
      pos = to_vector2f / size.to_f
      Point2i.new(
        pos.x.floor.to_i * size,
        pos.y.floor.to_i * size
      )
    end

    def to_tuple
      {x, y}
    end

    def to_point2f
      Point2(Float64).new(x.to_f, y.to_f)
    end

    def to_point2i
      Point2i.new(x.to_i, y.to_i)
    end

    def to_vector
      Vector2(T).new(x, y)
    end

    def to_vector2f
      Vector2f.new(x.to_f, y.to_f)
    end

    def to_sf
      to_sf_vector
    end

    def to_json(config : JSON::Builder)
      config.object do
        config.field "x", x
        config.field "y", y
      end
    end

    def inspect(io : IO)
      t = T.name.to_s.downcase[0]
      io << "Point2#{t}(x: %4.2f, y: %4.2f)" % {x, y}
    end
  end

  alias Point2i = Point2(Int32)
  alias Point2f = Point2(Float64)

  struct Point3(T)
    def self.zero
      new(T.zero, T.zero, T.zero)
    end

    getter x : T
    getter y : T
    getter z : T

    def initialize(v : T)
      initialize(v, v, v)
    end

    def initialize(@x, @y, @z)
    end

    def +(v : Vector3(X)) forall X
      self.class.new(x + v.x, y + v.y, z + v.z)
    end

    def -(v : Vector3(X)) forall X
      self + Vector3(X).new(-v.x, -v.y, -v.z)
    end

    def -(p : self) : Vector3(T)
      Vector3(T).new(x - p.x, y - p.y, z - p.z)
    end

    def *(v : Vector3(X)) forall X
      self.class.new(x * v.x, y * v.y, z * v.z)
    end

    def towards(target : self)
      target - self
    end

    def scale(f : T)
      self.class.new(x*f, y*f, z*f)
    end

    def scale(f : Float64)
      Point3f.new(x*f, y*f, z*f)
    end

    def aligned(size : Int32)
      pos = to_vec3f / size.to_f
      Point3i.new(
        pos.x.floor.to_i * size,
        pos.y.floor.to_i * size,
        pos.z.floor.to_i * size
      )
    end

    def to_tuple
      {x, y, z}
    end

    def to_point3f
      Point3(Float64).new(x.to_f, y.to_f, z.to_f)
    end

    # def to_vector
    #   Vector3(T).new(x, y, z)
    # end

    # def to_vec3f
    #   Vector3f.new(x.to_f, y.to_f, z.to_f)
    # end

    def to_json(config : JSON::Builder)
      config.object do
        config.field "x", x
        config.field "y", y
        config.field "z", z
      end
    end

    def inspect(io : IO)
      t = T.name.to_s.downcase[0]
      io << "Point3#{t}(x: %4.2f, y: %4.2f, z: %4.2f)" % {x, y, z}
    end
  end

  alias Point3i = Point3(Int32)
  alias Point3f = Point3(Float64)
end
