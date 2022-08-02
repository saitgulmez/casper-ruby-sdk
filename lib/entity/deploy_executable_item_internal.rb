module Casper
  module Entity
    class DeployExecutableItemInternal

      def initialize(deploy_named_args)
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

    end
  end
end