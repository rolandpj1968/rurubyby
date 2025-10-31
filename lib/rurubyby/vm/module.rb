module Rurubyby
  module Vm
    class Module < Object
      def initialize(name, namespace)
        raise "class/module name must be a symbol" unless name.class.equal?(Symbol)
        @name = name
        raise "class/module namespace must be a module" unless namespace.nil? or namespace.class.equal?(Module)
        @namespace = namespace
        @methods = {}
      end

      def find_method(name)
        @methods[name]
      end
    end
  end
end
