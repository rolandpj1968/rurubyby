require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class ModuleObject < ObjectObject
      # TODO - the Module class _can_ be subclassed in ruby - need to work out how to deal with that
      def initialize(name, namespace, class_object = Core::MODULE_CLASS)
        super(class_object)

        raise "class/module name must be a symbol" unless name.class.equal?(Symbol)
        @name = name
        # TODO - enclosing module CAN be a class!!!
        raise "class/module namespace must be a module" unless namespace.nil? or namespace.class.equal?(Core.MODULE_CLASS)
        @namespace = namespace
        @methods = {}
        @constants = {}
      end

      def set_method(name, unbound_method)
        raise "unbound_method must be an UnboundMethodObject" unless unbound_method.class.equal?(UnboundMethodObject)
        # TODO thread safety
        @methods[name] = unbound_method
      end

      def get_method(name)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        @methods[name]
      end
      
      def set_constant(name, value)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        @constants[name] = value
      end

      def get_constant(name)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        @constants[name]
      end

      # TODO brokken - lexical scope is NOT the same as enclosing module/class!!!
      def lookup_constant_in_lexical_scope(name)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        # 1. This module
        value = @constants[name]
        return value unless value.nil?

        # 2. Lexical scope
        # TODO - this is wrong!!! lexical scope is NOT the same as enclosing module/class!!!
        unless @namespace.nil?
          value = @namespace.lookup_constant(name)
          return value unless value.nil?
        end

        # 5.fail - missing_constant and raise are done by the VM
        nil
      end
    end
  end
end
