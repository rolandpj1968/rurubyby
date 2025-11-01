module Rurubyby
  module Vm
    class ObjectObject
      def initialize(class_object)
        unless class_object.class.equal?(ClassObject) || (class_object.nil? && Core.class_class.nil?)
          raise "ObjectObject class_object must be a ClassObject"
        end
        @class_object = class_object
        @instance_variables = {}
        @eigenclass = class_object # promoted to singleton class at first singleton method def
      end

      #def class_object = @class_object

      def create_singleton_class
        if @eigenclass.equal?(@class_object)
          @eigenclass = ClassObject.new(name = nil, namespace = nil, class_object)
        end
      end

      def define_singleton_method(name, method)
        create_singleton_class
        @eigenclass.define_method(name, method)
      end

      def lookup_method(name)
        @eigenclass.lookup_method(name)
      end
    end
  end
end
