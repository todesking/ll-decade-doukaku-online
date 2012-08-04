describe LLNOCrypt do
  describe LLNOCrypt::Distincter do
    it '文字列がIPv4かどうか判別できる'
    it '文字列がIPv6かどうか判別できる'
    it '文字列がMACアドレスかどうか判別できる'
  end
  describe '#decode_bits_to_char' do
    it '2ビットx4の並びを文字に変換できる'
  end
  describe '#decode' do
    `暗号文を解読できる'
  end
end
