require_relative './deploy_named_argument.rb'
require_relative './module_bytes.rb'
require_relative './deploy_executable_transfer.rb'

module Casper
  module Entity
    class DeployExecutable 

      def initialize
        @module_bytes = nil
        @stored_contract_by_hash = nil
        @stored_contract_by_name = nil
        @stored_versioned_contract_by_hash = nil
        @stored_versioned_contract_by_name = nil
        @transfer = nil
      end

      def standard_payment(payment_amount)
        @module_bytes = ModuleBytes.new("", [])
        arg = DeployNamedArgument.new("amount", CLu512.new(payment_amount))
        @module_bytes.set_arg(arg) # => Add arg and return args
        @module_bytes
      end

      # @param [Integer] id
      # @param [Integer] amount
      # @param [CLURef | CLPublicKey] target
      # @param [CLURef | CLPublicKey] source_purse
      # @return [DeployExecutable] 
      def new_transfer(id, amount, target, source_purse = nil)
        if target.instance_of? CLURef
          @target = target
        elsif target.instance_of? CLPublicKey
          @target = target.to_account_hash_byte_array
        else
          raise ArgumentError.new("Please specify target")
        end
        arg1 = DeployNamedArgument.new("amount", CLu512.new(amount))
        arg2 = DeployNamedArgument.new("target", @target)
        @transfer = DeployExecutableTransfer.new([])
        @transfer.set_arg(arg1)
        @transfer.set_arg(arg2)
        # @transfer

        if source_purse != nil
          @transfer.set_arg(DeployNamedArgument.new("source", source_purse))
          # @transfer
        end
        @transfer.set_arg(DeployNamedArgument.new("target", @target))
        @transfer.set_arg(DeployNamedArgument.new("id", CLu64.new(id)))
        @transfer
      end
    end
  end
end