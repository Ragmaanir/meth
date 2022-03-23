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
end

require "./meth/point"
require "./meth/vector"
require "./meth/dimension"
require "./meth/circle"
require "./meth/rect"
require "./meth/margin"
require "./meth/color"
require "./meth/intersection_tester"
