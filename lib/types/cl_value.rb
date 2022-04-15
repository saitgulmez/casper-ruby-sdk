
class CLValue 

  def initialize(hex_bytes, cl_type, parsed)
    @hex_bytes = hex_bytes
    @cl_type = cl_type
    @parsed = parsed
  end

  def cl_value?
  end

  def get_bytes
    @hex_bytes
  end

  def get_cl_type
    @cl_type
  end

  def get_parsed
    @parsed
  end

end