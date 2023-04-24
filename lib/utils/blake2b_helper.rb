
class Blake2bHelper

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

end