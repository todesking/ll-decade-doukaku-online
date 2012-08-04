# -*- coding: utf-8 -*-
require './llnocrypt'
describe LLNOCrypt do
  describe LLNOCrypt::Distincter do
    subject { LLNOCrypt::Distincter.new }
    describe '#ipv4?' do
      it '文字列がIPv4かどうか判別できる' do
        should be_ipv4 '0.0.0.0'
        should be_ipv4 '255.255.255.255'
        should be_ipv4 '0.12.255.0'
        should_not be_ipv4 '256.255.255.255'
        should_not be_ipv4 '0..0.0'
      end
      it '空文字列は受理しない' do
        should_not be_ipv4 ''
      end
      it '無駄なゼロがついてたらIPv4ではない' do
        should_not be_ipv4 '00.0.0.0'
      end
      it '数字の並びは4つ' do
        should_not be_ipv4 '0.0'
      end
    end
    describe '#ipv6?' do
      it '文字列がIPv6かどうか判別できる' do
        should be_ipv6 '0:0:0:0:0:0:0:0'
        should be_ipv6 '2001:1234:3210:ABCD:9876:3232:3812:FFAB'
        should be_ipv6 '0:2000:11:1:2:3:211:10'
        should_not be_ipv6 '0:0:0:0:0:0:0:X'
      end
      it '空文字列は受理しない' do
        should_not be_ipv4 ''
      end
      it '無駄なゼロがついていたらIPv6ではない' do
        should_not be_ipv6 '1:2:3:4:5:6:07:8'
      end
      it '小文字も受理する' do
        should be_ipv6 'ABCd:1234:5678:ffff:0:0:0:0'
      end
      it '数字の並びは8つ' do
        should_not be_ipv6 '1234:1'
      end
    end
    describe '#mac?' do
      it '文字列がMACアドレスかどうか判別できる' do
        should be_mac '00:11:22:33:44:FF'
        should be_mac '1A-B2-c3-d4-e5-f6'
        should_not be_mac 'XX:11:22:33:44:55'
        should_not be_mac '11:1:22:33:44:55'
        should_not be_mac '11:11:22:33:44:555'
        should_not be_mac ''
      end
      it '空文字列は受理しない' do
        should_not be_mac ''
      end
      it '区切り文字は統一されてる' do
        should_not be_mac '1A-B2:c3-d4-e5-f6'
      end
      it '数字の並びは6つ' do
        should_not be_mac 'a:b'
      end
    end
  end
  subject { LLNOCrypt.new }
  describe '#decode_bits_to_char' do
    it '2ビットx4の並びを文字に変換できる' do
      subject.decode_bits_to_char(0b01, 0b10, 0b00, 0b01).should == 'a'
      subject.decode_bits_to_char(0b00, 0b10, 0b10, 0b10).should == '*'
    end
  end
  describe  '#decode_str_to_num' do
    it '文字列を対応する数値に変換できる' do
      subject.decode_str_to_num('192.168.0.23').should == 0b01
      subject.decode_str_to_num('0:0:0:0:0:0:0:0').should == 0b10
      subject.decode_str_to_num('AA-BB-CC-DD-EE-FF').should == 0b00
      subject.decode_str_to_num('hoge').should == 0b11
    end
  end
  describe '#decode' do
    it '暗号文を解読できる' do
      src = <<-EOS.split(/\n/)
192.168.0.23
00:00:01:22:23:34
FF:DD:BB:AA:CC:EE
2001:db8:bd05:1d2:288a:1fc0:1:10ee
123.45.67.89
12:34:56:78:9a:bc
1A-2B:2E-09:12:22
300.100.200.10
10.232.33.44
90-12-03-92-00-01
01234:22:4444:34:5555:5:f
0.100.32.10
100.200.100.200
10:20:30:01:02:03
11-22-33-44-55-66
9f34:234:1:123:45:6:FFFF:FFF
      EOS
      subject.decode(src).should == 'BOMB'
    end
  end
end
