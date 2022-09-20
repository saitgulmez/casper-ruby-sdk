module Casper
  module Entity
    # Signature and Public Key of the signer.
    class DeployApproval 
     
      # @param [Hash] approval
      # @option approval [String] :signer
      # @option approval [String] :signature
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