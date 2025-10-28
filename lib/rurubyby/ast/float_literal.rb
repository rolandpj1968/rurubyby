module Rurubyby
  module Ast
    class FloatLiteral
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_s = value.to_s

      def self.from(value)
        raise "FloatLiteral value must be an Float not #{value.class}" unless value.is_a?(Float)
        # TODO dedup with hash
        new(value)
      end
    end
  end
end
