module Rurubyby
  module Ast
    class StringLiteral
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_s = value.to_s

      def self.from(value)
        raise "StringLiteral value must be an String not #{value.class}" unless value.is_a?(String)
        # TODO dedup with hash
        # TODO - handle locale encoding
        new(value)
      end
    end
  end
end
