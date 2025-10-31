module Rurubyby
  module Ast
    class MethodCall
      def initialize(method_name, receiver_node, arg_nodes)
        raise "method_name must be a Symbol" unless method_name.class.equal?(Symbol)
        @method_name = method_name
        @receiver_node = receiver_node # nil if no explicit receiver
        @arg_nodes = arg_nodes
      end

      def to_s
        "call(TODO)"
      end

      def eval(frame)
        receiver =
          if @receiver_node.nil?
            frame.the_self
          else
            @receiver_node.eval(frame)
          end
      
        args = @arg_nodes.map { |arg_node| arg_node.eval(frame) }

        method = receiver.find_method(@method_name)

        raise "method not found - not yet doing missing_method" if method.nil?

        new_frame = Vm::StackFrame.new(frame, receiver, method.locals)

        method.invoke(new_frame, args)
      end
    end
  end
end
