class LLNOCrypt
  class Distincter
    def ipv4? str
      return false if str.empty?
      str.split('.').each do|num_str|
        return false unless num_str =~ /^\d+$/
        num = num_str.to_i
        return false unless 0 <= num && num <= 255
        return false if num_str =~ /^0\d+/
      end
      return true
    end
    def ipv6? str
      return false if str.empty?
      str.split(':').each do|num_str|
        return false unless num_str =~ /^[0-9A-Fa-f]+$/
        num = num_str.to_i(16)
        return false unless 0x0000 <= num && num <= 0xFFFF
        return false if num_str =~ /^0.+/
      end
      return true
    end
  end
end
