require 'prism'

require_relative 'ast/nil_literal'
require_relative 'ast/true_literal'
require_relative 'ast/false_literal'
require_relative 'ast/self_literal'

require_relative 'ast/integer_literal'
require_relative 'ast/float_literal'
require_relative 'ast/string_literal'
require_relative 'ast/symbol_literal'

require_relative 'ast/sequence'

module Rurubyby
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
      else
        raise "Unexpected Prism node type #{prism_node.class}"
      end
    end
  end
end
