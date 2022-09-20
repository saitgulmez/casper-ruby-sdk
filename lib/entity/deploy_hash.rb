module Casper
  module Entity
    # Hex-encoded Deploy hash.
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