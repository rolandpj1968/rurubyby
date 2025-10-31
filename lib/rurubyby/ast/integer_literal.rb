require_relative '../vm/integer_object'

module Rurubyby
  module Ast
    class IntegerLiteral
      attr_reader :value

      def initialize(value)
        throw "IntegerLiteral value must be an IntegerObject" unless value.class.equal?(::Rurubyby::Vm::IntegerObject)
        @value = value
      end

      def to_s = "int(#{value})"

      def self.from(value)
        raise "IntegerLiteral value must be an Integer not #{value.class}" unless value.class.equal?(Integer)
        # TODO dedup with hash
        new(::Rurubyby::Vm::IntegerObject.new(value))
      end
    end
  end
end
