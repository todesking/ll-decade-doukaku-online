class LLNOCrypt
  class Distincter
    def ipv4? str
      return number_list?(str, '.', 10, 4, 0..255)
    end

    def ipv6? str
      return number_list?(str, ':', 16, 8, 0x0000..0xFFFF)
    end

    def mac? str
      return false unless str =~ /([-:])/
      separator = $1
      return number_list?(str, separator, 16, 6, 0x0000..0xFFFF, /^[0-9A-Fa-f]{2}$/)
    end

    private
    def number_list?(str, separator, base, length, num_range, num_pattern=nil)
      num_pattern ||= case base
                      when 10 then /^(0|[1-9][0-9]*)$/
                      when 16 then /^(0|[1-9A-Fa-f][0-9A-Fa-f]*)$/
                      else raise "base unsupported: #{base}"
                      end

      return false if str.empty?

      num_strs = str.split(separator,-1)
      return false unless num_strs.length == length

      num_strs.each do|num_str|
        return false unless num_str =~ num_pattern
        num = num_str.to_i(base)
        return false unless num_range.include? num
      end

      return true
    end

    def split_strict(str,sep)
      str.split(sep,-1)
    end
  end

  def initialize
    @distincter = Distincter.new
  end

  def decode_bits_to_char b3, b2, b1, b0
    num = (b3 << 6) + (b2 << 4) + (b1 << 2) + b0
    num.chr
  end

  def decode_str_to_num str
    case
    when @distincter.mac?(str)  then 0b00
    when @distincter.ipv4?(str) then 0b01
    when @distincter.ipv6?(str) then 0b10
    else                             0b11
    end
  end

  def decode lines
    lines.map(&:strip).each_slice(4).map{|chunk|
      chunk.map {|str|
        decode_str_to_num str
      }
    }.map{|chunk|
      decode_bits_to_char *chunk
    }.join
  end
end
