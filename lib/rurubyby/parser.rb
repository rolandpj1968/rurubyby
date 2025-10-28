require 'prism'

require_relative 'ast/nil_value'

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
          Ast::NilValue::NIL
        when 1
          transform(body[0])
        else
          raise "Prism::StatementsNode of length > 1 not supported"
        end
      when Prism::NilNode
        Ast::NilValue::NIL
      else
        raise "Unexpected Prism node type #{prism_node.class}"
      end
    end
  end
end
