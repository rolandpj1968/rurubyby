require_relative '../vm/integer_object'

module Rurubyby
  module Ast
    class IntegerLiteral
      def initialize(value)
        # native integers
        raise "IntegerLiteral value must be an Integer" unless value.class.equal?(Integer)
        #raise "IntegerLiteral value must be an IntegerObject" unless value.class.equal?(::Rurubyby::Vm::IntegerObject)
        @value = value
      end

      # Only via IntegerLiteral.from
      private_class_method :new

      def to_s = "int(#{@value})"

      def execute(_) = @value

      # TODO - thread-safety
      IntegerLiterals = {}

      def self.from(value)
        raise "IntegerLiteral value must be an Integer not #{value.class}" unless value.class.equal?(Integer)

        # native integers
        IntegerLiterals[value] ||= new(value)
        #IntegerLiterals[value] ||= new(::Rurubyby::Vm::IntegerObject.new(value))
      end
    end
  end
end
