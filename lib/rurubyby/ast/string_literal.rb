require_relative '../vm/string_object'

module Rurubyby
  module Ast
    class StringLiteral
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_s = "str(#{value})"

      # TODO - share with symbols
      # TODO - thread-safety
      StringLiterals = {}

      def self.from(value)
        raise "StringLiteral value must be an String not #{value.class}" unless value.is_a?(String)

        # TODO - handle locale encoding
        StringLiterals[value] ||= new(::Rurubyby::Vm::StringObject.new(value))
      end
    end
  end
end
