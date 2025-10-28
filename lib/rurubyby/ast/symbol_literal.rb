module Rurubyby
  module Ast
    class SymbolLiteral
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_s = value.to_s

      def self.from(value)
        raise "SymbolLiteral value must be an String not #{value.class}" unless value.is_a?(String)
        # TODO dedup (globally for all symbols) with hash
        # TODO - handle locale encoding
        new(value.to_sym)
      end
    end
  end
end
