module Rurubyby
  module Ast
    class IntegerLiteral
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_s = value.to_s

      def self.from(value)
        raise "IntegerLiteral value must be an Integer not #{value.class}" unless value.is_a?(Integer)
        # TODO dedup with hash
        new(value)
      end
    end
  end
end
