require_relative '../lib/utils/time_utils.rb'
require_relative '../lib/utils/byte_utils.rb'

RSpec.describe Utils::TimeUtils do
  let(:time_utils) { Utils::TimeUtils }
  let(:byte_utils) { Utils::ByteUtils }

  it "serialize 1603994401469 ms to 0xbd3a847575010000" do  
    expect("0x"+ byte_utils.to_u64(1603994401469)).to eql("0xbd3a847575010000")
    expect(byte_utils.to_u64(1603994401469)).to eql("bd3a847575010000")
  end

  it "should convert iso datetime to ms from unix epoch" do  
    date = "2020-11-17T00:39:24.072Z"  
    expect(time_utils.to_epoc_ms(date)).to eql(1605573564072)
  end

  it "should convert miliseconds to iso datetime" do  
    date = "2020-11-17T00:39:24.072Z"
    milliseconds = 1605573564072
    expect(time_utils.to_iso_string(milliseconds)).to eql("2020-11-17T00:39:24.072Z")
  end

  it "Milliseconds should not be negative" do
    milliseconds = -10
    expect {time_utils.to_iso_string(milliseconds)}.to raise_error(ArgumentError)
  end

  it "should convert ttl to milliseconds" do 
    time1 = time_utils.ttl_to_milliseconds("1d")
    expect(time1).to eql(86400000)
   
    time2 = time_utils.ttl_to_milliseconds("1h")
    expect(time2).to eql(3600000)
    
    time3 = time_utils.ttl_to_milliseconds("30m")
    expect(time3).to eql(1800000)
    
    time4 = time_utils.ttl_to_milliseconds("50s")
    expect(time4).to eql(50000)
    
    time5 = time_utils.ttl_to_milliseconds("90ms")
    expect(time5).to eql(90)
    
    time6 = time_utils.ttl_to_milliseconds("1d 1h 30m 50s 90ms")
    expect(time6).to eql(91850090)
    
    time7 = time_utils.ttl_to_milliseconds("1h 30m 50s 90ms")
    expect(time7).to eql(5450090)
    
    time8 = time_utils.ttl_to_milliseconds("30m 50s 90ms")
    expect(time8).to eql(1850090)
    
    time9 = time_utils.ttl_to_milliseconds("50s 90ms")
    expect(time9).to eql(50090)
    
    time10 = time_utils.ttl_to_milliseconds("90ms")
    expect(time10).to eql(90)
  end

  it "should convert milliseconds to ttl" do  
    ttl1 = time_utils.milliseconds_to_ttl(86400000)
    expect(ttl1).to eql("1d")
   
    ttl2 = time_utils.milliseconds_to_ttl(3600000)
    expect(ttl2).to eql("1h")
   
    ttl3 = time_utils.milliseconds_to_ttl(1800000)
    expect(ttl3).to eql("30m")
   
    ttl4 = time_utils.milliseconds_to_ttl(50000)
    expect(ttl4).to eql("50s")
   
    ttl5 = time_utils.milliseconds_to_ttl(90)
    expect(ttl5).to eql("90ms")
   
    ttl6 = time_utils.milliseconds_to_ttl(91850090)
    expect(ttl6).to eql("1d 1h 30m 50s 90ms")
   
    ttl7 = time_utils.milliseconds_to_ttl(5450090)
    expect(ttl7).to eql("1h 30m 50s 90ms")
   
    ttl8 = time_utils.milliseconds_to_ttl(1850090)
    expect(ttl8).to eql("30m 50s 90ms")
   
    ttl9 = time_utils.milliseconds_to_ttl(50090)
    expect(ttl9).to eql("50s 90ms")
   
    ttl10 = time_utils.milliseconds_to_ttl(90)
    expect(ttl10).to eql("90ms")
  end

end