module Meth
  struct Color
    getter r : UInt8
    getter g : UInt8
    getter b : UInt8
    getter a : UInt8

    Transparent = Color.new(0, 0, 0, 0)
    Black       = from_hex("000000")
    Red         = from_hex("ff0000")
    Green       = from_hex("00ff00")
    Blue        = from_hex("0000ff")
    White       = from_hex("ffffff")

    Yellow  = from_hex("ffff00")
    Magenta = from_hex("ff00ff")
    Cyan    = from_hex("00ffff")
    Orange  = from_hex("ffa500")

    def self.random
      [Red, Green, Blue, White, Yellow, Magenta, Cyan].sample
    end

    def self.from_hex(hex : String)
      raise "Hex string '#{hex}' is not in format 'rrggbb'" if hex.size != 6
      from_int(hex.downcase.to_i(16))
    end

    def self.from_int(i : Int32)
      new(
        (i & 0xff0000) >> 16,
        (i & 0x00ff00) >> 8,
        (i & 0x0000ff),
      )
    end

    def self.gray(v : UInt8)
      new(v, v, v)
    end

    def initialize(r : Float64, g : Float64, b : Float64, a : Float64 = 1)
      initialize((r*255).to_u8, (g*255).to_u8, (b*255).to_u8, (a*255).to_u8)
    end

    def initialize(r : Int32, g : Int32, b : Int32, a : Int32 = 255)
      initialize(r.to_u8, g.to_u8, b.to_u8, a.to_u8)
    end

    def initialize(@r, @g, @b, @a = 255_u8)
    end

    def override(idx : Int32, v : UInt8)
      map { |c, i| idx == i ? v : c }
    end

    def override(idx : Int32, v : Float64)
      raise "Color value out of range: #{v}" if !(0.0..1.0).includes?(v)
      override(idx, (255*v).to_u8)
    end

    def override(r : UInt8? = nil, g : UInt8? = nil, b : UInt8? = nil, a : UInt8? = nil)
      # values = [r, g, b, a]
      # map do |c, i|
      #   values[i] || c
      # end
      self.class.new(r || @r, g || @g, b || @b, a || @a)
    end

    def +(c : Color)
      # combine(c, ->(l, r) { l + r })
      map do |comp, idx|
        comp + c[idx]
      end
    end

    # private def combine(c : Color, f : (UInt8, UInt8) -> T)
    #   new(
    #     f(r, c.r),
    #     f(g, c.g),
    #     f(b, c.g),
    #     f(a, c.a)
    #   )
    # end

    def map(&f : (UInt8) -> T) : Color forall T
      self.class.new(*components.map(&f))
    end

    def map(&f : (UInt8, Int32) -> T) : Color forall T
      self.class.new(*components.map_with_index(&f))
    end

    # def map_with_index(&f : (UInt8, Int32) -> T) : Color forall T
    #   Color.new(*components.map_with_index(&f))
    # end

    def components : Tuple(UInt8, UInt8, UInt8, UInt8)
      {r, g, b, a}
    end

    def [](idx : Int32)
      components[idx]
    end
  end
end
