module Rurubyby
  module Ast
    class SymbolLiteral
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_s = "sym(#{value})"

      # TODO this needs to be hoisted into the VM runtime cos _all_ symbols are deduped, even dynamically created symbols
      # TODO - share with unique strings
      # TODO - thread-safety
      SymbolLiterals = {}

      class << self
        def from(value)
          raise "SymbolLiteral value must be an String not #{value.class}" unless value.is_a?(String)

          # TODO - handle locale encoding
          symbol = value.to_sym
          SymbolLiterals[symbol] ||= new(symbol)
        end
      end
    end
  end
end
