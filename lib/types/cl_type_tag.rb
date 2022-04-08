
class CLTypeTag
  TAGS = {
    Bool: 0,
    I32: 1,
    I64: 2,
    U8: 3,
    U32: 4,
    U64: 5,
    U128: 6,
    U256: 7,
    U512: 8,
    Unit: 9,
    String: 10,
    Key: 11,
    URef: 12,
    Option: 13,
    List: 14,
    ByteArray: 15,
    Result: 16,
    Map: 17,
    Tuple1: 18,
    Tuple2: 19,
    Tuple3: 20,
    Any: 21,
    PublicKey: 22
  }

  # Constructor 
  # @param [Integer] tag_value
  def initialize(tag_value)
    @tag_value = tag_value
  end

  # @param [Integer] tag_value
  # @return [Boolean] true or false
  def tag_value_isvalid(tag_value)
    TAGS.has_value?(tag_value)
    # "#{tag_value} is invalid CLType tag"
  end

  # @return [Integer] tag_value
  def get_tag_value
    @tag_value
  end

  # @return [String] 
  def get_tag_name
    TAGS.key(@tag_value).to_s
  end
end
