module Casper
  module Entity
    # Represents a transfer from one purse to another
    class Transfer
    
      # @param [Hash] transfer
      # @option transfer [String] :deploy_hash
      # @option transfer [String] :from
      # @option transfer [String] :to
      # @option transfer [String] :source
      # @option transfer [String] :target
      # @option transfer [String] :amount
      # @option transfer [String] :gas
      # @option transfer [Integer] :id
      def initialize(transfer = {})
        @deploy_hash = transfer[:deploy_hash]
        @from = transfer[:from]
        @to = transfer[:to]
        @source = transfer[:source]
        @target = transfer[:target]
        @amount = transfer[:amount]
        @gas = transfer[:gas]
        @id = transfer[:id]
      end

      # @return [String] deploy that created the transfer
      def get_deploy_hash
        @deploy_hash
      end

      # @return [String] account from which transfer was executed
      def get_from
        @from
      end

      # @return [String] account to which funds are transferred
      def get_to
        @to
      end

      # @return [String] tource purse
      def get_source
        @source
      end

      # @return [String] target purse
      def get_target
        @target
      end

      # @return [String] transfer amount
      def get_amount
        @amount
      end

      # @return [String] gas
      def get_gas
        @gas
      end
      # @return [Integer] user-defined id
      def get_id
        @id
      end
    end
  end
end