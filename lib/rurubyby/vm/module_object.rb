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
        raise "class/module namespace must be a module" unless namespace.nil? or namespace.class.equal?(Core.MODULE_CLASS)
        @namespace = namespace
        @methods = {}
      end

      # TODO - really bad naming cos of existing method
      def set_method(name, unbound_method)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)
        raise "unbound_method must be an UnboundMethodObject" unless unbound_method.class.equal?(UnboundMethodObject)
        # TODO thread safety
        @methods[name] = unbound_method
      end

      def lookup_method(name)
        @methods[name]
      end
    end
  end
end
