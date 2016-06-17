module Meth
  module Misc
    extend self

    def hash_snake(inp : Hash)
      ret = {} of String => String | Int32 | Bool | Char
      inp.each do |elem|
        ret[elem[0].to_s.split("").map { |ch| ch == ch.downcase ? ch : "_#{ch.downcase}" }.join("")] = elem[1]
      end
      ret
    end
  end
end
