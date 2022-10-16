require_relative './deploy_named_argument.rb'
require_relative '../serialization/deploy_named_arg_serializer'
module Casper
  module Entity
    # DeployExecutableItemInternal
    class DeployExecutableItemInternal
      attr_accessor :args
      def initialize(deploy_named_args = [])
        @args = deploy_named_args
      end

      # @return [Array<DeployNamedArg>]
      def get_args
        @args
      end

      # @return [DeployNamedArg]
      def get_arg_by_name(arg)
        @args.include?(arg) == true ? arg : nil
      end

      def set_arg(deploy_named_arg)
        @args << [deploy_named_arg]
      end
    end
  end
end