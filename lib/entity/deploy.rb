module Casper
  module Entity
    class Deploy
    
      # @param [String] hash
      # @param [DeployHeader] header
      # @param [DeployExecutable] payment
      # @param [DeployExecutable] session
      # @param [DeployApproval] approvals
      def initialize(hash, header, payment, session, approvals)
        @hash = hash
        @header = header
        @payment = payment
        @session = session
        @approvals = approvals
      end

      # @return [String] hash
      def get_hash
        @hash 
      end

      # @return [DeployHeader] header
      def get_header
        @header 
      end

      # @return [DeployExecutable] payment
      def get_payment 
        @payment  
      end

      # @return [DeployExecutable] session
      def get_session 
        @session  
      end

      # @return [DeployApproval] approvals
      def get_approvals
        @approvals  
      end
    end
  end
end