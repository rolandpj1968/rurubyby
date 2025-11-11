module Rurubyby
  module Ast
    class Or
      def initialize(left_node, right_node)
        @left_node = left_node
        @right_node = right_node
      end

      def to_s
        "or(#{@left_node}, #{@right_node})"
      end

      def execute(context)
        left_value = @left_node.execute(context)
        return left_value unless left_value.equal?(Vm::FalseObject::FALSE) || left_value.equal?(Vm::NilObject::NIL)

        @right_node.execute(context)
      end
    end
  end
end
