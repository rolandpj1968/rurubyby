module Rurubyby
  module Vm
    class Module < Object
      def initialize(name, namespace)
        @name = name
        raise "class/module namespace must be a module" unless namespace.nil? or namespace.klass.equal?(Module)
        @namespace = namespace
        @methods = {}
      end

      def find_method(name)
        @methods[name]
      end
    end
  end
end
