require_relative './cl_type.rb'
require_relative './constants.rb'



class CLURefType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    TAGS.key(12).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end

  def to_bytes
    [12].pack("C*").unpack1("H*")
  end
end

AccessRights = {
  # No permissions
  None: 0b00000000,
  # Permission to read the value under the associated [[URef]].
  READ: 0b00000001,
  # Permission to write a value under the associated [[URef]].
  WRITE: 0b00000010,
  # Permission to read or write the value under the associated [[URef]].
  READ_WRITE: 0b00000011,
  # Permission to add to the value under the associated [[URef]].
  ADD: 0b00000100,
  # # Permission to read or add to the value under the associated [[URef]].
  READ_ADD: 0b00000101,
  # # Permission to add to, or write the value under the associated [[URef]].
  ADD_WRITE: 0b00000110,
  # # Permission to read, add to, or write the value under the associated [[URef]].
  READ_ADD_WRITE: 0b00000111
}
