class LLNOCrypt
  class Distincter
    def ipv4? str
      return false if str.empty?
      str.split('.').each do|num_str|
        return false unless num_str =~ /^\d+$/
        return false if num_str =~ /^0\d+/
        num = num_str.to_i
        return false unless 0 <= num && num <= 255
      end
      return true
    end
    def ipv6? str
      return false if str.empty?
      str.split(':').each do|num_str|
        return false unless num_str =~ /^[0-9A-Fa-f]+$/
        return false if num_str =~ /^0.+/
        num = num_str.to_i(16)
        return false unless 0x0000 <= num && num <= 0xFFFF
      end
      return true
    end
    def mac? str
      return false if str.empty?
      return false unless str =~ /([-:])/
      separator = $1
      str.split(separator).each do|num_str|
        return false unless num_str =~/^[0-9A-Fa-f]+$/
        return false if num_str =~ /^0.+/
        num = num_str.to_i(16)
        return false unless 0x0000 <= num && num <= 0xFFFF
      end
      return true
    end
  end
end
