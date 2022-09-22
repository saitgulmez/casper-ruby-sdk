module Casper
  module Entity
    # BlockBody  
    class BlockBody

      # @param [String] proposer
      # @param [Array] deploy_hashes
      # @param [Array] transfer_hashes
      def initialize(body =  {})
        @proposer = body[:proposer]
        @deploy_hashes = body[:deploy_hashes]
        @transfer_hashes = body[:transfer_hashes]
      end

      # @return [String] proposer
      def get_proposer
        @proposer
      end

      # @return [Array] deploy_hashes
      def get_deploy_hashes
        @deploy_hashes
      end

      # @return [Array] transfer_hashes
      def get_transfer_hashes
        @transfer_hashes
      end

    end
  end
end