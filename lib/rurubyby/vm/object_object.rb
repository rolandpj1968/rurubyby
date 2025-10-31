module Rurubyby
  module Vm
    class ObjectObject
      def initialize(klass)
        raise "ObjectObject klass must be a ClassObject" unless klass.class.equal?(ClassObject)
        @klass = klass
        @instance_variables = {}
        @eigenclass = klass # promoted to singleton class at first singleton method def
      end

      def klass = @klass

      def create_singleton_class
        if @eigenclass.equal?(@klass)
          @eigenclass = ClassObject.new(name = nil, namespace = nil, klass)
        end
      end

      def define_singleton_method(name, method)
        create_singleton_class
        @eigenclass.define_method(name, method)
      end

      def find_method(name)
        @eigenclass.find_method(name)
      end
    end
  end
end
