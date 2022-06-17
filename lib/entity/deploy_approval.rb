module Casper
  module Entity
    class DeployApproval 

      # @param [String] signer
      # @param [String] signature
      def initialize(approval = {})
        @signer = approval[:signer]
        @signature = approval[:signature]
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