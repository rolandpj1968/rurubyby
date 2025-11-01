module Rurubyby
  module Ast
    class Sequence
      def initialize(nodes)
        @nodes = nodes
      end

      def to_s
        "seq(#{@nodes.map(&:to_s).join('; ')})"
      end

      def execute(frame)
        result = nil

        @nodes.each do |node|
          result = node.execute(frame)
        end

        result
      end
    end
  end
end
