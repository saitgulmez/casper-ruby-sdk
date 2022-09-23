module Casper
  module Entity
    # BlockBody entity 
    class BlockBody

      # @param [Hash] body
      # @option [String] :proposer
      # @option [Array] :deploy_hashes
      # @option [Array] :transfer_hashes
      def initialize(body =  {})
        @proposer = body[:proposer]
        @deploy_hashes = body[:deploy_hashes]
        @transfer_hashes = body[:transfer_hashes]
      end

      # @return [String] a hex-encoded cryptographic public key, 
      #   including the algorithm tag prefix.
      def get_proposer
        @proposer
      end

      # @return [Array] hex-encoded Deploy hashes.
      def get_deploy_hashes
        @deploy_hashes
      end

      # @return [Array] a vector of hex-encoded hashes 
      #   identifying Transfers included in this block.
      def get_transfer_hashes
        @transfer_hashes
      end

    end
  end
end