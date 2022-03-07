
module Casper
  module RpcError
    class ErrorHandle  
      # @param [Integer]  RPC Error code
      # @param [String] RPC Error short message
      # @param [String]  Full stack RPC error  message
      def initialize(code = 0, message = "", data = "") 
        @code = code
        @message = message
        @data = data
      end

      def self.invalid_param 
        @code = -32602
        @message = "Invalid params"
        "Server error -32602: Invalid params"
      end

      def error_handling(url)
        begin
          response = RestClient.get(url)
          parsed = JSON.parse(response)
          # p parsed
        rescue RestClient::ResourceNotFound => e
          e.class.inspect
          # "ResourceNotFound"
        rescue Errno::ECONNREFUSED => e
          e.class.inspect
          # p e.class
          # "Errno::ECONNREFUSED"
        rescue SocketError => e
           e.class.inspect
          # "Socket Error"
        end
      end 

      def invalid_address
        "getaddrinfo: Name or service not known (SocketError)"
      end

      def invalid_parameter
        "Server error -32602: Invalid params"
      end
    end
    
    class ServerError < StandardError
      def initialize(code, message)
        super("Server error #{code}: #{message}")
      end
    end

    class InvalidParameter

      def initialize  
      end
      
      def self.error
        "Server error -32602: Invalid params"
      end      

      def self.argument_error
        "ArgumentError"
      end
    end

  end
end