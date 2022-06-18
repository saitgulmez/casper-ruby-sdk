module Casper
  module Entity
    class DeployNamedArgument

      def initialize(name, clvalue)
        @name = name
        @value = clvalue
      end

      def get_name
        @name
      end

      def get_value
        @value
      end
    end
  end
end