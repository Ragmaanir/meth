require "./dim3"

module Meth
  class Array3D(T)
    record(Coord, x : Int32, y : Int32, z : Int32) do
      def to_tuple
        {x, y, z}
      end
    end

    include Enumerable({Coord, T})

    getter dimension : Dim3i
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

      Coord.new(t[0], t[1], t[2])
    end

    def []?(coord : {Int32, Int32, Int32}) : T?
      self[Coord.new(*coord)]?
    end

    def [](coord : {Int32, Int32, Int32}) : T
      self[Coord.new(*coord)]
    end

    def []=(coord : {Int32, Int32, Int32}, value : T)
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
      dimension.depth.times do |z|
        dimension.height.times do |y|
          dimension.width.times do |x|
            coord = Coord.new(x, y, z)
            block.call({coord, self[coord]})
          end
        end
      end
    end

    def map(&block : (Coord, T) -> _)
      res = self.class.new(dimension) { |c|
        block.call(c, self[c])
      }
    end
  end # Array3D
end
