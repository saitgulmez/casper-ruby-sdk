module Casper
  module Entity
    # BlockProof 
    class BlockProof
      # @param [Hash] proof
      # @option proof [String] :public_key
      # @option proof [String] :signature 
      def initialize(proof = {})
        @public_key = proof[:public_key]
        @signature = proof[:signature]
      end

      # @return [String] public_key
      def get_public_key
        @public_key
      end

      # @return [String] signature
      def get_signature
        @signature
      end
    end
  end
end