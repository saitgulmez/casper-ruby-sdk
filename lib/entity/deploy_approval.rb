module Casper
  module Entity
    class DeployApproval 

      # @param [String] signer
      # @parama [String] signature
      def initialize(signer = "", signature = "")
        @signer = signer
        @signature = signature
      end

      # @return [String] signer
      def get_signer
        @signer
      end
      
      # return [String] signature
      def get_signature
        @signature
      end
    end
  end
end