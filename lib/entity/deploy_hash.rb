module Casper
  module Entity
    class DeployHash

      # @param [String] hash
      def initialize(hash)
        @hash = hash
      end

      # @return [String] hash
      def get_hash
        @hash
      end
    end
  end
end