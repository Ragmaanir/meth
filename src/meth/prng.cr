module Meth::PRNG
  # static uint32_t m_state = 123456789;
  #
  # uint32_t mulberry32() {
  #     m_state += 0x6D2B79F5;
  #     uint32_t t = m_state;
  #     t = (t ^ (t >> 15)) * (t | 1);
  #     t ^= t + (t ^ (t >> 7)) * (t | 61);
  #     return t ^ (t >> 14);
  # }
  #
  # float random_float() {
  #     return (mulberry32() >> 9) * (1.0f / (1U << 23)) * 2.0f - 1.0f;
  # }
  class Mulberry32
    getter state : UInt32 = 123456789

    def int32
      @state += 0x6D2B79F5
      t = @state
      t = (t ^ (t >> 15)) * (t | 1)
      t ^= t + (t ^ (t >> 7)) * (t | 61)
      t ^ (t >> 14)
    end

    def float32
      (int32 >> 9) * (1.0_f32 / (1_u32 << 23)) * 2.0_f32 - 1.0_f32
    end
  end

  module MathHelpers
    # convert UInt32 range int to bipolar float in the range [-1,1]
    def to_bifloat32(h : UInt32)
      (h / UInt32::MAX.to_f32) * 2.0_f32 - 1.0_f32
    end

    # range [0,1]
    def to_unifloat32(h : UInt32)
      h / UInt32::MAX.to_f32
    end
  end

  module Noise2D
    abstract def int32(a : Int32, b : Int32) : UInt32
  end

  # uint32_t wyhash_mix(uint32_t a, uint32_t b) {
  #     uint64_t seed = ((uint64_t)a << 32) | b;
  #     seed ^= seed >> 32;
  #     seed *= 0xa0761d6478bd642f;
  #     seed ^= seed >> 32;
  #     seed *= 0xa0761d6478bd642f;
  #     seed ^= seed >> 32;
  #     return (uint32_t)seed;
  # }
  class Wyhash
    include Noise2D
    include MathHelpers

    MAGIC = 0xa0761d6478bd642f_u64

    def int32(a : Int32, b : Int32) : UInt32
      seed = (a.to_u64! << 32) | b.to_u64!
      seed ^= seed >> 32
      seed &*= MAGIC
      seed ^= seed >> 32
      seed &*= MAGIC
      seed ^= seed >> 32
      seed.to_u32!
    end

    def bifloat32(a : Int32, b : Int32) : Float32
      to_bifloat32(int32(a, b))
    end

    def unifloat32(a : Int32, b : Int32) : Float32
      to_unifloat32(int32(a, b))
    end
  end

  # uint32_t murmur_mix(uint32_t a, uint32_t b) {
  #     uint32_t h = a * 0xcc9e2d51 + b * 0x1b873593;
  #     h ^= h >> 16;
  #     h *= 0x85ebca6b;
  #     h ^= h >> 13;
  #     h *= 0xc2b2ae35;
  #     h ^= h >> 16;
  #     return h;
  # }
  class Murmur
    include Noise2D
    include MathHelpers

    def int32(a : Int32, b : Int32) : UInt32
      h = a.to_u32! &* 0xcc9e2d51 &+ b.to_u32! &* 0x1b873593
      h ^= h >> 16
      h &*= 0x85ebca6b
      h ^= h >> 13
      h &*= 0xc2b2ae35
      h ^= h >> 16
      h
    end

    def bifloat32(a : Int32, b : Int32) : Float32
      to_bifloat32(int32(a, b))
    end

    def unifloat32(a : Int32, b : Int32) : Float32
      to_unifloat32(int32(a, b))
    end
  end
end
