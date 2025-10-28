module Rurubyby
  module Ast
    class NilValue
      NIL = NilValue.new

      def to_s = "nil"
    end
  end
end
