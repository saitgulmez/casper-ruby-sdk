require_relative '../lib/utils/time_utils.rb'
require_relative '../lib/utils/byte_utils.rb'

RSpec.describe Utils::TimeUtils do
  let(:time_utils) { Utils::TimeUtils }
  let(:byte_utils) { Utils::ByteUtils }

  it "serialize 1603994401469 ms to 0xbd3a847575010000" do  

  end

  it "should convert iso datetime to ms from unix epoch" do  
    date = "2020-11-17T00:39:24.072Z"
    expect(time_utils.to_epoc_ms(date)).to eql(1605573564072)
  end
end