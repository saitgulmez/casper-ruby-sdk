require './cl_type_tag.rb'
require './constants.rb'


class CLType    

    def initialize(tag, link_to)
        @tag = tag
        @link_to = link_to 
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

    # @return [Array<Integer>]
    def to_bytes
      arr = Uint8Array.new( @tag.get_tag_value)
    end
    
    def call_enum
        CLTypeTag::TAGS
    end

end
