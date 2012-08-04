# -*- coding: utf-8 -*-
require './llnocrypt'
describe LLNOCrypt do
  describe LLNOCrypt::Distincter do
    subject { LLNOCrypt::Distincter.new }
    describe 'ipv4?' do
      it '文字列がIPv4かどうか判別できる' do
        should be_ipv4 '0.0.0.0'
        should be_ipv4 '255.255.255.255'
        should be_ipv4 '0.12.255.0'
        should_not be_ipv4 '256.255.255.255'
        should_not be_ipv4 '0..0.0'
      end
      it '無駄なゼロがついてたらIPv4ではない' do
        should_not be_ipv4 '00.0.0.0'
      end
    end
    it '文字列がIPv6かどうか判別できる'
    it '文字列がMACアドレスかどうか判別できる'
  end
  describe '#decode_bits_to_char' do
    it '2ビットx4の並びを文字に変換できる'
  end
  describe '#decode' do
    it '暗号文を解読できる'
  end
end
