require_relative '../vm/integer_object'

module Rurubyby
  module Ast
    class IntegerLiteral
      attr_reader :value

      def initialize(value)
        raise "IntegerLiteral value must be an IntegerObject" unless value.class.equal?(::Rurubyby::Vm::IntegerObject)
        @value = value
      end

      def to_s = "int(#{value})"

      def eval = @value

      # TODO - thread-safety
      IntegerLiterals = {}

      def self.from(value)
        raise "IntegerLiteral value must be an Integer not #{value.class}" unless value.class.equal?(Integer)

        IntegerLiterals[value] ||= new(::Rurubyby::Vm::IntegerObject.new(value))
      end
    end
  end
end
