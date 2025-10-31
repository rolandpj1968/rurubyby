module Rurubyby
  module Ast
    class SelfLiteral
      SELF = SelfLiteral.new

      def to_s = "self"

      def eval(frame) = frame.the_self
    end
  end
end
