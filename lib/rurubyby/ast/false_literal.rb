require_relative '../vm/false_object'

module Rurubyby
  module Ast
    class FalseLiteral
      FALSE = FalseLiteral.new

      def to_s = "false"

      def eval = ::Rurubyby::Vm::FalseObject::FALSE_OBJECT
    end
  end
end
