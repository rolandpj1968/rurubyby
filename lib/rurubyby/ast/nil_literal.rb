module Rurubyby
  module Ast
    class NilLiteral
      NIL = NilLiteral.new

      def to_s = "nil"

      def execute(_) = ::Rurubyby::Vm::NilObject::NIL_OBJECT
    end
  end
end
