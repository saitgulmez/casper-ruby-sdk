require_relative './cl_key_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'
=begin
Key values serialize as a single byte tag representing the variant, followed by the serialization of the data that variant contains. 
For most variants, this is simply a fixed-length 32-byte array. 
The exception is Key::URef, which contains a URef; so its data serializes per the description above. 
The tags are as follows: Key::Account serializes as 0, Key::Hash as 1, Key::URef as 2.
=end


KEY_TYPE_ACCOUNT = 0
KEY_TYPE_HASH    = 1
KEY_TYPE_UREF    = 2

ACCOUNT_HASH_ID = 'AccountHash'
ACCOUNT_HASH_LENGTH = 32

UREF_ID = 'URef'

class CLKey < CLValue  
  include CLValueBytesParsers::CLKeyBytesParser

  def initialize(value)
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLKeyType.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

