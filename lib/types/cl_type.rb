require 'json'

class CLType    
  TAGS = {
    # Boolean primitive.
    Bool:  0,
    # Signed 32-bit integer primitive.
    I32:  1,
    # Signed 64-bit integer primitive.
    I64:  2,
    # Unsigned 8-bit integer primitive.
    U8:  3,
    # Unsigned 32-bit integer primitive.
    U32:  4,
    # Unsigned 64-bit integer primitive.
    U64:  5,
    # Unsigned 128-bit integer primitive.
    U128:  6,
    # Unsigned 256-bit integer primitive.
    U256:  7,
    # Unsigned 512-bit integer primitive.
    U512:  8,
    # Singleton value without additional semantics.
    Unit: 9,
    # A string. e.g. "Hello, World!".
    String: 10,
    # Global state key.
    Key: 11,
    # Unforgeable reference.
    URef: 12,
    # Optional value of the given type Option(CLType).
    Option: 13,
    # Variable-length list of values of a single `CLType` List(CLType).
    List: 14,
    # Fixed-length list of a single `CLType` (normally a Byte).
    ByteArray: 15,
    # Co-product of the the given types; one variant meaning success, the other failure.
    Result: 16,
    # Key-value association where keys and values have the given types Map(CLType, CLType).
    Map: 17,
    # Single value of the given type Tuple1(CLType).
    Tuple1: 18,
    # Pair consisting of elements of the given types Tuple2(CLType, CLType).
    Tuple2: 19,
    # Triple consisting of elements of the given types Tuple3(CLType, CLType, CLType).
    Tuple3: 20,
    # Indicates the type is not known.
    Any: 21,
    # A Public key.
    PublicKey: 22
  }

  def initialize(value = nil)
    @value = value
  end

  # @return [String]
  def to_string

  end

  def to_json

  end

  def get_link_to

  end

  def get_tag   

  end

  # @return [String] 
  def get_tag_name
    TAGS.key(@value).to_s
  end

  # @return [Integer] tag_value
  def get_tag_value
    @tag_value
  end

  def get_tags
    TAGS
  end

  # @param [Integer] tag_value
  # @return [Boolean] true or false
  def tag_value_isvalid(value)
    TAGS.has_value?(value)
  end
end
