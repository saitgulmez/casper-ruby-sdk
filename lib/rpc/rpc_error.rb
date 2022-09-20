
module Casper
  module RpcError
    # Exception handling
    class ErrorHandle  
      # @param [Integer] code
      # @param [String] message
      # @param [String] data
      def initialize(code = 0, message = "", data = "") 
        @code = code
        @message = message
        @data = data
      end

      # @return [String] err
      def self.invalid_param 
        @code = -32602
        @message = "Invalid params"
        @err = "Server error #{@code}: #{@message}"
      end

      # @param [String] url
      # @return [String]
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
        rescue
          "Timed out connecting to server"
        end
      end 

      # @return [String]
      def invalid_address
        "getaddrinfo: Name or service not known (SocketError)"
      end

      # @return [String]
      def invalid_parameter
        "Server error -32602: Invalid params"
      end
    end
    
    class ServerError < StandardError

      # @return [String]
      def initialize(code, message)
        super("Server error #{code}: #{message}")
      end
    end

    class InvalidParameter

      def initialize  
      end
      
      # @return [String]
      def self.error
        "Server error -32602: Invalid params"
      end      

      # @return [String]
      def self.argument_error
        "ArgumentError"
      end
    end

  end
end