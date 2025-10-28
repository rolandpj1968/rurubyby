require_relative 'parser'

module Rurubyby
  class Vm
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      script = options[:script]

      if script
        puts "Executing: '#{script}'"

        ast = Parser.new(script).ast

        puts
        puts "AST root isa #{ast.class}"
        puts
        puts "AST: #{ast}"
      else
        puts "No script given"
      end
    end
  end
end
