module Utils
  module Helpers
    extend self
    def construct_inner_clvalue(cl_type, value)
      if cl_type == "U64"
        CLu64.new(value)
      end
    end
  end
end