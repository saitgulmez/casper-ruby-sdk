require 'casper_sdk'

client = CasperClient.new
# puts client.info_get_peers
# puts client.chain_get_StateRootHash
# puts client.info_get_deploy
puts client.state_get_AuctionInfo