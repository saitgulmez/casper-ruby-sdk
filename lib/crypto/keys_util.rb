
module Utils
  module KeysUtil
    extend self

    # @return Uint8Array
    def read_base64_with_pem(content) 

    end

    def to_pem(tag, content)
      "-----BEGIN #{tag}-----\n" +
      "#{content}\n" +
      "-----END #{tag}-----\n" 
    end

    
    
  end
end