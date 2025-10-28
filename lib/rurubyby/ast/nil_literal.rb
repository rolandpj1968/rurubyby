module Rurubyby
  module Ast
    class NilLiteral
      NIL = NilLiteral.new

      def to_s = "nil"
    end
  end
end
