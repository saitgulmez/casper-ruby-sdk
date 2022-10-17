require_relative './cl_type.rb'

# A Casper value, i.e. a value which can be stored and manipulated by smart contracts.
class CLValue

  def initialize(bytes = nil, cl_type =  nil, parsed = nil)
    @bytes = bytes
    @cl_type = cl_type
    @parsed = parsed
  end

  def to_hash(bytes, value, type)
    {
      "bytes": bytes,
      "parsed": value,
      "cl_type": type
    }
  end
end
