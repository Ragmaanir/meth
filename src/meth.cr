require "kontrakt"

struct Float32
  def close_to?(other : self, epsilon : self = 2*Float32::EPSILON)
    (self - other).abs <= epsilon
  end
end

struct Float64
  def close_to?(other : self, epsilon : self = 2*Float64::EPSILON)
    (self - other).abs <= epsilon
  end
end

module Meth
  VERSION = "0.1.0"

  module Shape
  end

  alias Ratio = Float64

  module Factories
    def p2f(*args)
      Meth::Point2f.new(*args)
    end

    def p2i(*args)
      Meth::Point2i.new(*args)
    end

    def v2f(*args)
      Meth::Vector2f.new(*args)
    end

    def v2i(*args)
      Meth::Vector2i.new(*args)
    end

    def d2f(*args)
      Meth::Dim2f.new(*args)
    end

    def d2i(*args)
      Meth::Dim2i.new(*args)
    end
  end

  extend Factories

  def self.scalar_format_string(c : T.class) forall T
    if c < Int
      "%d"
    elsif c < Float
      "%4.2f"
    else
      raise "Unhandled type: #{c}"
    end
  end

  def self.inspect_composite(io : IO, name : String, *values : T) forall T
    io << name
    io << T.class.name.to_s.downcase[0]
    io << "("

    f = Meth.scalar_format_string(T)

    values.each_with_index { |v, i|
      io << ", " unless i == 0
      io << f % v
    }
    io << ")"
  end
end

require "./meth/point"
require "./meth/vector"
require "./meth/dim2"
require "./meth/dim3"
require "./meth/circle"
require "./meth/rect"
require "./meth/margin"
require "./meth/color"
require "./meth/intersection_tester"
require "./meth/prng"
