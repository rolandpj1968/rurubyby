module Rurubyby
  module Ast
    class SelfLiteral
      SELF = SelfLiteral.new

      def to_s = "self"

      def execute(context) = frame.the_self
    end
  end
end
