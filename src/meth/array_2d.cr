require "./dim2"

module Meth
  class Array2D(T)
    record(Coord, x : Int32, y : Int32)

    # include Enumerable({Coord, T})

    getter dimension : Dim2i
    getter array : Array(T)

    def initialize(@dimension, value : T)
      @array = Array(T).new(dimension.product, value)
    end

    def initialize(@dimension, &f : Coord -> T)
      @array = Array(T).new(dimension.product) { |i|
        f.call(coord_for(i))
      }
    end

    def length
      dimension.product
    end

    private def index_for(coord : Coord)
      coord.x * dimension.height + coord.y
    end

    private def coord_for(idx : Int32)
      x = idx % dimension.x
      y = idx // dimension.x

      Coord.new(x, y)
    end

    def []?(coord : {Int32, Int32}) : T?
      self[Coord.new(*coord)]?
    end

    def [](coord : {Int32, Int32}) : T
      self[Coord.new(*coord)]
    end

    def []=(coord : {Int32, Int32}, value : T)
      self[Coord.new(*coord)] = value
    end

    def []?(coord : Coord) : T?
      array[index_for(coord)]?
    end

    def [](coord : Coord) : T
      self[coord]? || raise("Coords out of bounds: #{coord} -> #{index_for(coord)}")
    end

    def []=(coord : Coord, value : T)
      array[index_for(coord)] = value
    end

    def each(&block : (Coord, T) -> _)
      each do |coord, value|
        block.call(coord, value)
      end
    end

    def each(&block : ({Coord, T}) -> _)
      dimension.width.times { |x|
        dimension.height.times { |y|
          coord = Coord.new(x, y)
          block.call({coord, self[coord]})
        }
      }
    end

    def map(&block : (Coord, T) -> _)
      res = self.class.new(dimension) { |c|
        block.call(c, self[c])
      }
    end
  end # Array3D
end
