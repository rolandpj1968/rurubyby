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

      def execute(context)
        receiver =
          if @receiver_node.nil?
            frame.the_self
          else
            @receiver_node.execute(context)
          end
      
        args = @arg_nodes.map { |arg_node| arg_node.execute(context) }

        method = receiver.lookup_method(@method_name)

        # TODO - this is a runtime exception, not an assert
        raise "method not found - not yet doing missing_method" if method.nil?

        new_frame = Vm::Frame.new(receiver, method.locals, method.scopes)
        context.push_frame(new_frame)
        begin
          method.invoke(context, args)
        ensure
          context.pop_frame
        end
      end
    end
  end
end
