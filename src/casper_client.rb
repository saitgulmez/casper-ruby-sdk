# ruby_sdk.rb
require 'jimson'
require 'json'

class CasperClient
	attr_accessor :ip_address, :port, :node_id 
	
	def initialize(ip_address = "", port = 0)
		@ip_address = ip_address
		@port = port
	end

end

