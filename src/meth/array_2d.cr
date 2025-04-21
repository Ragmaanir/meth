require "./dim2"

module Meth
  class Array2D(T)
    record(Coord, x : Int32, y : Int32) do
      def to_tuple
        {x, y}
      end
    end

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

    def initialize(@dimension, a : Array(T))
      if dimension.product != a.size
        raise("Array size does not match: #{@dimension} <=> #{a.size}")
      end

      @array = a.dup
    end

    def length
      dimension.product
    end

    private def index_for(coord : Coord)
      dimension.index_for_coord(coord.to_tuple)
    end

    private def coord_for(idx : Int32)
      t = dimension.coord_for_index(idx)

      Coord.new(t[0], t[1])
    end

    def [](idx : Int32) : T
      array[idx]
    end

    def []=(idx : Int32, v : T) : T
      array[idx] = v
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
      dimension.height.times { |y|
        dimension.width.times { |x|
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

    def inspect_square(io : IO)
      each { |coord, v|
        io.print("%3d" % v)
        io.puts if coord.x == dimension.width - 1
      }
    end
  end # Array3D
end
