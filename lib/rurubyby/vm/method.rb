module Rurubyby
  module Vm
    class Method
      # TODO - default params, keyword params, block param
      def initialize(scopes, name, params, locals, ast)
        # TODO - array of class/modules
        raise "scopes must be an array of ClassObjects/ModuleObjects" unless scopes.class.equal?(Array)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)
        # TODO - array of symbols
        raise "params must be an array of Symbols" unless params.class.equal?(Array)
        # TODO - array of symbols
        raise "locals must be an array of Symbols" unless locals.class.equal?(Array)

        @scopes = Method.unique_scopes(scopes)
        @name = name
        @params = params
        @locals = locals
        @ast = ast
      end

      def scopes = @scopes

      def params = @params

      def locals = @locals

      def ast = @ast

      # TODO - thread-safety
      UniqueScopes = {}

      def self.unique_scopes(scopes)
        UniqueScopes[scopes] ||= scopes.dup
      end
    end
  end
end
