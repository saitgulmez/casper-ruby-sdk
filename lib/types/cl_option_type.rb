require_relative './cl_type.rb'
require_relative './cl_bool.rb'
require_relative './cl_bool_type.rb'
require_relative './constants.rb'

optionTags = {
  NONE: 0,
  SOME: 1
}

class CLOptionType < CLType

  def initialize(inner)
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

  def get_inner_type
    @inner
  end


end




  # def initialize(inner_type = nil)  
  #   super
  #   @inner_type = inner_type
  #   @tag = TAGS["Option"].to_s
  # end

  # def to_string
  #   TAGS.key(13).to_s
  #   if @inner_type == nil
  #     TAGS.key(13).to_s + " (None)"
  #   else
  #     @inner_type.get_cl_tag
  #     TAGS.key(13).to_s + " (#{@inner_type.to_string})"
  #   end
  # end

  # def to_json 
  #   to_string
  # end

  # def get_inner_type
  #   @inner_type
  # end

  # def get_tag
  #   @tag
  # end

  # def to_bytes

  # end