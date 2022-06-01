module Utils
  module HexUtils

    # @param [String] public_key_hex
    # @return [Boolean]
    def valid_public_key_format?(public_key_hex)
      # !!"01f9235ff9c46c990e1e2eee0d531e488101fab48c05b75b8ea9983658e228f06b".match(/^0(1[0-9a-fA-F]{64}|2[0-9a-fA-F]{66})$/)
      !!public_key_hex.match(/^0(1[0-9a-fA-F]{64}|2[0-9a-fA-F]{66})$/)
    end
  end
end