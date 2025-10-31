require_relative 'core'
require_relative 'object'

module Rurubyby
  module Vm
    class SymbolObject < Object
      def initialize(value)
        raise "SymbolObject must have an Symbol value" unless value.class.equal?(Symbol)

        super(Core::SYMBOL_CLASS)

        @value = value
      end

      def to_s = ":#{@value}"
    end
  end
end

