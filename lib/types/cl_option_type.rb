require_relative './cl_type.rb'
require_relative './cl_bool.rb'
require_relative './cl_bool_type.rb'
require_relative './constants.rb'

optionTags = {
  NONE: 0,
  SOME: 1
}

class CLOptionType < CLType
  def initialize(inner_type = nil)  
    super
    @inner_type = inner_type
    @tag = TAGS["Option"].to_s
  end

  def to_string
    TAGS.key(13).to_s
    if @inner_type.get_value == nil
      TAGS.key(13).to_s + " (None)"
    else
      TAGS.key(13).to_s + " (#{@inner_type.to_string})"
    end
  end

  def to_json 
    to_string
  end

  def get_inner_type
    @inner_type
  end

  def get_tag
    @tag
  end

end