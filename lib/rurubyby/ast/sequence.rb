module Rurubyby
  module Ast
    class Sequence
      def initialize(nodes)
        @nodes = nodes
      end

      def to_s
        "seq(#{@nodes.map(&:to_s).join('; ')})"
      end

      def eval(frame)
        result = nil

        @nodes.each do |node|
          result = node.eval(frame)
        end

        result
      end
    end
  end
end
