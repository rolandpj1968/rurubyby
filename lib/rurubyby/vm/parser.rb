require 'prism'

require_relative '../ast'

module Rurubyby
  module Vm
    class Parser
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def ast
        program_node = Prism.parse(text).value
        puts program_node.inspect

        raise "Unexpected Prism.parse value type #{value.class} expecting Prism::ProgramNode" unless program_node.is_a?(Prism::ProgramNode)

        transform(program_node.statements)
      end

      private

      def transform(prism_node)
        case prism_node
        when Prism::StatementsNode
          body = prism_node.body

          case body.length
          when 0
            Ast::NilLiteral::NIL
          when 1
            transform(body[0])
          else
            Ast::Sequence.new(body.map { |pn| transform(pn) })
          end

        when Prism::NilNode
          Ast::NilLiteral::NIL

        when Prism::TrueNode
          Ast::TrueLiteral::TRUE

        when Prism::FalseNode
          Ast::FalseLiteral::FALSE

        when Prism::SelfNode
          Ast::SelfLiteral::SELF

        when Prism::IntegerNode
          Ast::IntegerLiteral.from(prism_node.value)

        when Prism::FloatNode
          Ast::FloatLiteral.from(prism_node.value)

        when Prism::StringNode
          Ast::StringLiteral.from(prism_node.unescaped)

        when Prism::SymbolNode
          Ast::SymbolLiteral.from(prism_node.unescaped)

        when Prism::LocalVariableReadNode
          Ast::LocalVariableRead.new(prism_node.name, prism_node.depth)

        when Prism::ConstantReadNode
          Ast::ConstantRead.new(prism_node.name)

        when Prism::CallNode
          # TODO - only when parsing core files
          if prism_node.name.equal?(:__intrinsic__)
            raise "__intrinsic__ calls cannot have an explicit receiver" unless prism_node.receiver.nil?
            args = prism_node.arguments.arguments

            raise "__intrinsic__ call must include class name and method" unless args.length >= 2
            raise "__intrinsic__ class name must be a String" unless args[0].class.equal?(Prism::StringNode)
            raise "__intrinsic__ method name must be a Symbol" unless args[1].class.equal?(Prism::SymbolNode)

            Ast::IntrinsicCall.new(args[0].unescaped, args[1].unescaped.to_sym, args[2..].map { |pn| transform(pn) })
          else
            receiver_node = prism_node.receiver.nil? ? nil : transform(prism_node.receiver)

            Ast::MethodCall.new(prism_node.name, receiver_node, prism_node.arguments.arguments.map { |pn| transform(pn) })
          end

        when Prism::ClassNode
          # Prism seems a bit weird - it successfully parses class defns where the class name can be an arbitrary expression
          #   prehaps looking to the future?
          unless prism_node.constant_path.class.equal?(Prism::ConstantReadNode)
            raise "class defs with nested namespaced paths are not yet implemented"
          end
          unless prism_node.constant_path.name.class.equal?(Symbol) and prism_node.constant_path.name.equal?(prism_node.name)
            raise "Prism or RPJ or both are confused"
          end
          # TODO - disappointing that we need to use upcase here
          unless prism_node.name.length > 0 && prism_node.name[0].upcase == prism_node.name[0]
            # TODO - this is a real runtime error
            raise "class name '#{prism_node.name} is not a valid constant name"
          end
          body_ast = transform(prism_node.ast) unless prism_node.body.nil?
          Ast::ClassDef.new(prism_node.name, prism_node.locals, body_ast)
        else
          raise "Unexpected Prism node type #{prism_node.class}"
        end
      end
    end
  end
end
