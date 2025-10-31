require_relative 'parser'

module Rurubyby
  module Vm
    class Vm
      def initialize(options)
        @options = options
      end

      def run
        # TODO - set up top-level environment

        scripts = @options[:scripts]

        scripts.each do |script|
          result = execute(script)

          puts
          puts "result: #{result}"
        end

        # if -e is present then ruby DOES NOT execute an ARGV file
        # Note: ruby -e 'ARGV.each {|f| load f}' file1.rb file2.rb file3.rb
        if scripts.empty?
          # if -e is absent then ruby executes the FIRST file only
          file = @options[:argv][0]
          unless file.nil?
            script = File.read(file)

            result = execute(script)

            puts
            puts "result: #{result}"
          end
        end

        puts
        puts "Strings: #{Ast::StringLiteral::StringLiterals.transform_values(&:to_s)}"
        puts
        puts "Symbols: #{Ast::SymbolLiteral::SymbolLiterals.transform_values(&:to_s)}"
        puts
        puts "Integers: #{Ast::IntegerLiteral::IntegerLiterals.transform_values(&:to_s)}"
      end

      private

      def execute(script)
        puts "Executing: '#{script}'"

        ast = Parser.new(script).ast

        puts
        puts "AST root isa #{ast.class}"
        puts
        puts "AST: #{ast}"

        ast.eval
      end
    end
  end
end
