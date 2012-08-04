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
      it '数字の並びは4つ'
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
        should be_ipv6 'ABCd:1234:5678:ffff'
      end
      it '数字の並びは8つ'
    end
    describe '#mac?' do
      it '文字列がMACアドレスかどうか判別できる' do
        should be_mac '0:11:22:333:4444:FFFF'
        should be_mac '1A-B2-c3-d4-e5-f6'
        should_not be_mac 'XX:11:22:33:44:55'
        should_not be_mac ''
      end
      it '空文字列は受理しない' do
        should_not be_mac ''
      end
      it '無駄なゼロがついていたらMACではない' do
        should_not be_mac 'aa-bb-cc-dd-ee-00'
      end
      it '区切り文字は統一されてる' do
        should_not be_mac '1A-B2:c3-d4-e5-f6'
      end
      it '数字の並びは6つ'
    end
  end
  describe '#decode_bits_to_char' do
    it '2ビットx4の並びを文字に変換できる'
  end
  describe '#decode' do
    it '暗号文を解読できる'
  end
end
