module Rurubyby
  module Ast
    class IntrinsicCall
      def initialize(class_name, method_name, arg_nodes)
        @method = IntrinsicCall.method_for(class_name, method_name)
        @arg_nodes = arg_nodes
      end

      def to_s
        # @method.owner is class's eigenclass??? - not sure how to get the Class name
        "__intrinsic__[#{@method.owner}.#{@method.name}](#{@arg_nodes.map(&:to_s).join('; ')})"
      end

      def eval
        args = @arg_nodes.map(&:eval)

        @method.call(*args)
      end

      # TODO - thread safety
      Methods = {}

      def self.method_for(class_name, method_name)
        raise 'IntrinsicCall class_name must be a String' unless class_name.class.equal?(String)
        raise 'IntrinsicCall method_name must be a Symbol' unless method_name.class.equal?(Symbol)
        Methods[[class_name, method_name]] ||= Kernel.const_get(class_name).method(method_name)
      end
    end
  end
end
