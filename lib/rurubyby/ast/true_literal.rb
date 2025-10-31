require_relative '../vm/true_object'

module Rurubyby
  module Ast
    class TrueLiteral
      TRUE = TrueLiteral.new

      def to_s = "true"

      def eval = ::Rurubyby::Vm::TrueObject::TRUE_OBJECT
    end
  end
end
