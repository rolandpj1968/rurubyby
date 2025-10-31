require_relative 'object_object'

module Rurubyby
  module Vm
    class ModuleObject < ObjectObject
      def initialize(name, namespace)
        raise "class/module name must be a symbol" unless name.class.equal?(Symbol)
        @name = name
        raise "class/module namespace must be a module" unless namespace.nil? or namespace.class.equal?(Core.MODULE_CLASS)
        @namespace = namespace
        @methods = {}
      end

      def find_method(name)
        @methods[name]
      end
    end
  end
end
