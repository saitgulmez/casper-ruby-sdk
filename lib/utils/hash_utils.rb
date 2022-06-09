require 'blake2'

module Utils
  module HashUtils
    module_function

    def byte_hash(arr)
      str = arr.pack("C*").unpack("H*").first
      key = Blake2::Key.none
      Blake2.bytes(str, key, 32)
    end

    def account_hash_from_byte_to_hex(account_hash_byte_array)
      prefix = "account-hash-"
      hash_hex = account_hash_byte_array.pack("C*").unpack("H*").first
      prefix + hash_hex
    end
  end
end
