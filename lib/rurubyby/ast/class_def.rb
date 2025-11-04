# Ugh, bad coupling
require_relative '../vm/nil_object'

module Rurubyby
  module Ast
    class ClassDef
      def initialize(class_name, locals, ast)
        raise "class_name must be a Symbol" unless class_name.class.equal?(Symbol)
        @class_name = class_name

        raise "class defn with locals not yet supported" unless locals.empty?
        @locals = locals

        @ast = ast
      end

      def to_s
        "class(#{@class_name}, TODO)"
      end

      def execute(context)
        # 1. find or create the class defn and constant
        # TODO

        context.scopes << @class_name
        new_frame = Vm::Frame.new(context.frame.the_self, @locals, context.scopes)
        context.push_frame(new_frame)

        begin
          @ast.execute(context) unless @ast.nil?
          # Always nil
          #  $ ruby -e "a = class C; end; puts a.class"
          #  NilClass
          Vm::NilObject::NIL_OBJECT
        ensure
          context.pop_frame
          context.scopes.pop
        end
      end
    end
  end
end
