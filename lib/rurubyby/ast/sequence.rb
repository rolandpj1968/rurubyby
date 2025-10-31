module Rurubyby
  module Ast
    class Sequence
      def initialize(nodes)
        @nodes = nodes
      end

      def to_s
        "seq(#{@nodes.map(&:to_s).join('; ')})"
      end

      def eval
        result = nil

        @nodes.each do |node|
          result = node.eval
        end

        result
      end
    end
  end
end
