require_relative './cl_type.rb'
require_relative './cl_bool.rb'
require_relative './cl_bool_type.rb'
require_relative './constants.rb'

optionTags = {
  NONE: 0,
  SOME: 1
}

class CLOptionType < CLType

  def initialize(inner = nil)
    @tag = TAGS[:Option]
    @inner = inner
    # p @inner.to_string
    # p @inner.to_json
    # p @inner.get_tag
  end

  # @return [String]
  def to_string
    @inner == nil ? TAGS.key(13).to_s + " (None)" : TAGS.key(13).to_s + " (#{@inner.to_string})"
  end

  def to_json
    jsoned =  { "#{TAGS.key(13)}": @inner.to_string }.to_json
    # h = JSON.parse(jsoned)
    # h
  end

  def get_type
    TAGS.key(13).to_s
  end

  def get_inner_type
    @inner
  end

  def to_bytes
    arr = []
    arr << @tag << @inner.get_tag
  end

  def self.to_string
    TAGS.key(13).to_s
  end

  def to_bytes
    [13].pack("C*").unpack1("H*")
  end
end
