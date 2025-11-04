# Ugh, bad coupling - perhaps unavoidable with ruby semantics :(
require_relative "../vm/core"
require_relative '../vm/module_object'
require_relative '../vm/nil_object'

module Rurubyby
  module Ast
    class ClassDef
      def initialize(name, locals, ast)
        raise "class name must be a Symbol" unless name.class.equal?(Symbol)
        @name = name

        raise "class defn with locals not yet supported" unless locals.empty?
        @locals = locals

        @ast = ast
      end

      def to_s
        "class(#{@name}, TODO)"
      end

      def execute(context)
        # 1. find or create the class defn and constant
        class_constant = Vm::ModuleObject.lookup_constant(@name, context.scopes)
        puts "previous constant #{class_constant}/#{class_constant.class}"
        unless class_constant.nil? or class_constant.class.equal?(Vm::Core::CLASS_CLASS)
          # this is a real runtime error, not an assert
          raise "previous defn of #{@name} was not a class"
        end
        if class_constant.nil?
          # TODO namespace and superclass
          class_constant = Vm::ClassObject.new(@name, nil, nil)
          context.scopes.last.set_constant(@name, class_constant)
        end

        context.scopes << class_constant
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
