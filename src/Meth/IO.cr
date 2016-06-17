module Meth
  module IO
    extend self

    def del_chars(pipe, str, amount = 1)
      str = str[0...-amount]
      unless str.size <= 0
        pipe.print "\b \b"*amount
        pipe.flush
      end
      str = str[0...-amount]
    end

    def getch(pipe = STDIN)
      pipe.raw do |io|
        input = io.gets 1
        pipe.flush
        return "" unless input
        input
      end
    end

    def gets(autochomp = false, replacement = nil)
      str = ""
      loop do
        ch = getch
        next if ch == "\e"
        str = str + ch
        if replacement.nil?
          print ch
        else
          if replacement == false
            print ""
          else
            unless ch == "\u{7f}" || ch == "\r"
              print replacement
            end
          end
        end
        case ch
        when "\r"
          str = str[0...-1] + "\n"
          puts
          break
        when "\u{3}"
          print "^C"
          exit 1
        when "\u{7f}"
          if replacement
            str = del_chars STDOUT, str, replacement.size
          else
            str = del_chars STDOUT, str
          end
        end
      end
      if autochomp
        str.chomp
      else
        str
      end
    end

    def split(str, delim)
      if delim == ""
        return str.split("")
      elsif str.includes? delim
        return str.split(delim)
      end
      return [] of String
    end
  end
end
