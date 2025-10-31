require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class ModuleObject < ObjectObject
      # TODO - the Module class _can_ be subclassed in ruby - need to work out how to deal with that
      def initialize(name, namespace, klass = Core::MODULE_CLASS)
        super(klass)
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
