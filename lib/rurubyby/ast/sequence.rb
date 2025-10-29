module Rurubyby
  module Ast
    class Sequence
      attr_reader :nodes

      def initialize(nodes)
        puts "Sequence.initialize nodes isa #{nodes.class}"
        @nodes = nodes
      end

      def to_s
        "seq(#{nodes.map(&:to_s).join('; ')})"
      end
    end
  end
end
