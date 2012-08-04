class LLNOCrypt
  class Distincter
    def ipv4? str
      str.split('.').each do|num_str|
        return false unless num_str =~ /^\d+$/
        num = num_str.to_i
        return false unless 0 <= num && num <= 255
        return false if num_str =~ /^0\d+/
      end
      return true
    end
  end
end
