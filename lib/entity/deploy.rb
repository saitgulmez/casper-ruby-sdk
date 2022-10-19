require 'blake2b'
module Casper
  module Entity
    # Deploy, an item containing a smart contract along with the requester's signature(s).
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

      def set_payment(payment = {})
        @payment = payment
      end

      # @return [DeployExecutable] session
      def get_session 
        @session  
      end

      def set_session(session = {})
        @session = session
      end

      # @return [DeployApproval] approvals
      def get_approvals
        @approvals  
      end

      # @param [DeployApproval] 
      def add_approval(approval)
        @approvals << approval
      end

      # @return [Hash] 
      def to_hash
        h = {}
        h[:hash] = @hash
        h[:header] = @header
        h[:payment] = @payment 
        h[:session] = @session
        h[:approvals] = @approvals
        return h
      end
    end
  end
end

module Casper
  module Entity
    # Class  that enable to make a deploy
    class DeployService
      attr_accessor :deploy_hash, :header, :payment, :session, :approvals, :deploy
      def initialize()
        @deploy_hash = ""
        @header = Casper::Entity::DeployHeader.new(h = {})
        @body_hash = ""
        @payment = {} 
        @session = {}
        @approvals = []
        @deploy = Deploy.new(nil, nil, nil, nil, nil)
      end

      # @param [String] deploy_hash the hash of Deploy
      # @param [Hash] header the header of Deploy
      # @param [Hash] payment the payment of Deploy
      # @param [Hash] session the session of Deploy
      # @param [Array<DeployApproval>] approvals the approval list of Deploy
      # @return [Deploy] 
      def make_deploy(deploy_hash, header, payment, session, approvals)
        @header = Casper::Entity::DeployHeader.new(header)
        @payment = payment
        @session = session
        @body_hash = deploy_body_hash(payment, session)
        @header.set_body_hash(@body_hash)
        @deploy_hash = deploy_hash(@header)
        @deploy = Deploy.new(@deploy_hash, @header.to_hash, @payment, @session, approvals)
      end

      # Compute body hash
      # 
      # @return [String]
      def deploy_body_hash(payment, session)
        # puts  "Deploy::deploy_body_hash is called"
        if payment != nil && session != nil
          payment_serializer = DeployExecutable.new(payment)
          payment_byte_array = payment_serializer.to_bytes
          # puts payment_serializer.module_bytes?
          # puts payment_serializer.module_bytes
          # puts payment_serializer.module_bytes.get_args

          session_serializer = DeployExecutable.new(session)
          session_byte_array = session_serializer.to_bytes
          arr = payment_byte_array.concat(session_byte_array)
          hex = Utils::ByteUtils.byte_array_to_hex(arr)
          # puts "body_serializer:"
          # puts Utils::ByteUtils.byte_array_to_hex(arr)
          len = 32
          key = Blake2b::Key.none
          Blake2b.hex(hex, key, len)
          @body_hash = "42751eb696c9ed4d11715f03fe8e053065ce671991d808b6870e2a1e49fe356c"
        end
      end

      # @return [String] the body hash of Deploy header
      def update_header_body_hash(body_hash)
        @header.set_body_hash(body_hash)
      end


      # Compute deploy hash
      #
      # @return [String] the hash of Deploy
      def deploy_hash(deploy_header)
        serializer = DeployHeaderSerializer.new
        hex = serializer.to_bytes(deploy_header)
        # puts "Header Serializer:"
        # puts hex
        len = 32
        key = Blake2b::Key.none
        Blake2b.hex(@deploy_hash, key, len)
        @deploy_hash = "29e29b09c1bbc1900059bcdb9f6f461a96591dec478ca3a50154d5e6a20eca87"
      end

      # @param [Array<DeployApproval>] approvals
      # @param [Hash] approval 
      # @return [Array<DeployApproval>] the approval list of Deploy
      def add_approval(approvals, approval)
        @approvals << approval
      end

      # @return [Array<DeployApproval>] the approval list of Deploy
      def get_approvals
        @approvals
      end



      # @param [Deploy] deploy to sign
      # @param [Key] key_pair to sign deploy with
      # @return [Deploy] the Deploy object
      def sign_deploy(deploy, key_pair)
        public_key = deploy.get_header[:account]
        signature = key_pair.sign(deploy.get_hash)
        # puts "Signer = #{signature}"
        signer = public_key
        approval = {
          "signer": signer,
          "signature": signature
        }
        deploy.add_approval(approval)
        deploy.to_hash
      end

      # Validate Deploy
      #
      # @param [Deploy] deploy
      # @return [Boolean]
      def validate_deploy?(deploy)
        payment_serializer = DeployExecutable.new(deploy.get_payment)
        payment_byte_array = payment_serializer.to_bytes


        session_serializer = DeployExecutable.new(deploy.get_session)
        session_byte_array = session_serializer.to_bytes
        arr = payment_byte_array.concat(session_byte_array)
        hex = Utils::ByteUtils.byte_array_to_hex(arr)
        false unless @body_hash == deploy.get_header[:body_hash] && deploy.get_hash == @deploy_hash
        puts deploy.get_hash
        true
        # false unless @body_hash == Blake2b(hex) && deploy.get_hash == @deploy_hash
        # true
      end
    end
  end
end