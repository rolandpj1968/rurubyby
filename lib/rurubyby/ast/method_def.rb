# Ugh, bad coupling - perhaps unavoidable with ruby semantics :(
require_relative "../vm/core"
require_relative '../vm/module_object'
require_relative '../vm/nil_object'

module Rurubyby
  module Ast
    class MethodDef
      def initialize(name, locals, ast)
        raise "class name must be a Symbol" unless name.class.equal?(Symbol)
        @name = name

        # TODO - must be an array of Symbols
        raise "locals must be an array of Symbols" unless locals.class.equal?(Array)
        raise "class defn with locals not yet supported" unless locals.empty?
        @locals = locals

        @ast = ast
      end

      def execute(context)
        Core::INTEGER_CLASS.set_method(
          :+,
          Method.new(
            [Core::INTEGER_CLASS], # scopes
            :+,
            [:v],
            [:v],
            Ast::IntrinsicCall.new(
              '::Rurubyby::Vm::IntegerObject',
              :add,
              [
                Ast::SelfLiteral::SELF,
                Ast::LocalVariableRead.new(:v, 3)
              ]
            )
          )
        )
        # Ruby seems to generate the method name
        #   ruby -e 'a = def m = 3; puts a; puts a.class' -> m, Symbol
        
      end
    end

    def 
  end
end
