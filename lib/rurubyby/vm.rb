require_relative 'parser'

module Rurubyby
  class Vm
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      # TODO - set up top-level environment

      scripts = options[:scripts]

      scripts.each { |script| execute(script) }

      # if -e is present then ruby DOES NOT execute an ARGV file
      # Note: ruby -e 'ARGV.each {|f| load f}' file1.rb file2.rb file3.rb
      if scripts.empty?
        # if -e is absent then ruby executes the FIRST file only
        file = options[:argv][0]
        unless file.nil?
          script = File.read(file)
          execute(script)
        end
      end

      # TODO - run 
      puts
      puts "Symbols: #{Ast::SymbolLiteral::SymbolLiterals.transform_values(&:to_s)}"
    end

    private

    def execute(script)
      puts "Executing: '#{script}'"

      ast = Parser.new(script).ast

      puts
      puts "AST root isa #{ast.class}"
      puts
      puts "AST: #{ast}"
    end
  end
end
