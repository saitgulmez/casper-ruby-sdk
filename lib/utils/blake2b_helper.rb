
class Blake2bHelper
    BLAKE2B_IV32 = [
    0xf3bcc908, 0x6a09e667, 0x84caa73b, 0xbb67ae85, 0xfe94f82b, 0x3c6ef372, 
    0x5f1d36f1, 0xa54ff53a, 0xade682d1, 0x510e527f, 0x2b3e6c1f, 0x9b05688c, 
    0xfb41bd6b, 0x1f83d9ab, 0x137e2179, 0x5be0cd19
    ]
    SIGMA8 = [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 14, 10, 4, 8, 9, 15, 13,
      6, 1, 12, 0, 2, 11, 7, 5, 3, 11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1,
      9, 4, 7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8, 9, 0, 5, 7, 2, 4,
      10, 15, 14, 1, 11, 12, 6, 8, 3, 13, 2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5,
      15, 14, 1, 9, 12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11, 13, 11, 7,
      14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10, 6, 15, 14, 9, 11, 3, 0, 8, 12, 2,
      13, 7, 1, 4, 10, 5, 10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0, 0,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 14, 10, 4, 8, 9, 15, 13, 6,
      1, 12, 0, 2, 11, 7, 5, 3
    ]

    SIGMA82 = SIGMA8.map { |n|  n*2 }
    V = Array.new(32, 0)
    M = Array.new(32, 0)


  def initialize
    @ctx = {
      b: Array.new(128, 0),
      h: Array.new(16),
      t: 0, # Input counter
      c: 0, # Pointer within buffer
      outlen: 0 # Output length in bytes
    }
  end

  def add64_aa(v, a, b)
    # If the value of o0 is higher than u32_max then reset its value to zero
    o0 = v[a] + v[b]
    # If the value of o1 is higher than u32_max then reset its value to zero
    o1 = v[a + 1] + v[b + 1]
    max_i32 = 0x100000000
    u32_max = 0xffffffff

    if o0 >= max_i32
      # if o1 >= u32_max
      #   o1 = o1 & 0xffffffff
      # elsif o1 < 0
      #   o1 = 0
      # else
      #   o1 += 1
      # end
        o1 += 1
    end
    # if o0.to_s(2).size > 32
    #   v[a] = 0
    # else
      o0 = o0 & 0xffffffff
      o1 = o1 & 0xffffffff
      v[a] = o0
    # end
    # if o1.to_s(2).size > 32
    #   v[a + 1] = 0
    # else
      v[a + 1] = o1
    # end
  end

   def b2b_g(a, b, c, d, ix, iy)
    x0 = M[ix]
    x1 = M[ix + 1]
    y0 = M[iy]
    y1 = M[iy + 1]

    add64_aa(V, a, b) 

    add64_ac(V, a, x0, x1) 
    xor0 = bitwise_xor(V[d], V[a])
    
    xor1 = bitwise_xor(V[d + 1], V[a + 1])

    V[d] = convert_signed_value_to_u32(xor1)
    V[d + 1] = convert_signed_value_to_u32(xor0)
    add64_aa(V, c, d)

    # v[b,b+1] = (v[b,b+1] xor v[c,c+1]) rotated right by 24 bits
    xor0 = bitwise_xor(V[b], V[c])
    xor1 = bitwise_xor(V[b + 1], V[c + 1])

    xor0 = xor0 & 0xFFFF_FFFF if xor0 > 0
    xor1 = xor1 & 0xFFFF_FFFF if xor1 > 0
    V[b] = convert_signed_value_to_u32(bitwise_xor((right_shift_u32(xor0, 24)), (xor1 << 8)))
    V[b + 1] = convert_signed_value_to_u32(bitwise_xor((right_shift_u32(xor1, 24)), (xor0 << 8)))

    add64_aa(V, a, b)
    add64_ac(V, a, y0, y1)

    # v[d,d+1] = (v[d,d+1] xor v[a,a+1]) rotated right by 16 bits
    xor0 = bitwise_xor(V[d], V[a])
    xor1 = bitwise_xor(V[d + 1], V[a + 1])
    V[d] = convert_signed_value_to_u32(bitwise_xor((right_shift_u32(xor0, 16)), (xor1 << 16)))
    V[d + 1] = convert_signed_value_to_u32(bitwise_xor((right_shift_u32(xor1, 16)), (xor0 << 16)))

    add64_aa(V, c, d)

    # v[b,b+1] = (v[b,b+1] xor v[c,c+1]) rotated right by 63 bits
    xor0 = bitwise_xor(V[b], V[c])
    xor1 =  bitwise_xor(V[b + 1], V[c + 1])
    V[b] = convert_signed_value_to_u32(bitwise_xor((xor1 >> 31), (xor0 << 1)))
    V[b + 1] = convert_signed_value_to_u32(bitwise_xor((xor0 >> 31), (xor1 << 1)))
  end 
  
  def bitwise_not(n)
    binary = n.to_s(2)
    size = binary.size
    if size < 32
      binary.insert(0, "0"*(32-size))
    end
    updated = binary.chars.map do |ch|
      if ch == '0'
        ch = '1'
      elsif ch == '1'
        ch = '0'
      else
        ch = '0'
      end
    end
    str = updated.join()
    return str.to_i(2)
  end

  def bitwise_xor(a, b)
    u32_max = 0xffffffff
    i32_max = 0x7fffffff
    result = (a ^ b) & u32_max
    result -= 4294967296 if result > i32_max
    result
  end

  def convert_signed_value_to_u32(n)
    # result = n + (2**32)
    
    # Bitwise AND
    # result = n & (0xFFFF_FFFF)

    [n].pack("L").unpack("L").first
  end

  def right_shift_u32(value, n)
    if n < 0
      raise "n should not be negative value"
    end
    if value < 0
      binary_str = [value].pack('L>').unpack1('B*')
      binary_str.slice!(-n, n)
      binary_str = "0"*n + binary_str
      binary_str.to_i(2)
    else 
      value >> n
    end
  end
end