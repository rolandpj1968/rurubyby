require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    # Mmm, do we want to objectify this for all methods?
    class UnboundMethodObject < ObjectObject
      # TODO - default params, keyword params, block param
      def initialize(owner, scopes, name, params, locals, ast)
        super(Core::UNBOUND_METHOD_CLASS)

        # TODO Module class _can_ be subclassed - unlike Class class
        unless owner.class.equal?(ClassObject) || owner.class.equal?(ModuleObject)
          raise "UnboundMethodObject owner must be ClassObject or ModuleObject"
        end
        # TODO - array of class/modules
        raise "scopes must be an array of ClassObjects/ModuleObjects" unless scopes.class.equal?(Array)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)
        # TODO - array of symbols
        raise "params must be an array of Symbols" unless params.class.equal?(Array)
        # TODO - array of symbols
        raise "locals must be an array of Symbols" unless locals.class.equal?(Array)

        @owner = owner
        @scopes = UnboundMethodObject.unique_scopes(scopes)
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
        scopes = scopes.dup
        UniqueScopes[scopes] ||= scopes
      end
    end
  end
end
