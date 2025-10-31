#require_relative 'core'
require_relative 'module_object'

module Rurubyby
  module Vm
    class ClassObject < ModuleObject
      def initialize(name, namespace, superclass)
        super(name, namespace, Core.class_class)
        puts "class :#{name} = Core.class_class isa #{Core.class_class.class}"
        raise "superclass must be a ClassObject" unless superclass.nil? or superclass.class.equal?(ClassObject)
        @superclass = superclass
        @prepends = nil
        @modules = nil
      end

      # class "Class" circular depenency band-aid - see core.rb too
      def patch_class_object
        puts "class :#{@name} = Core.class_class isa #{Core.class_class.class}"
        @class_object = Core.class_class
      end

      def prepend_module(mod)
        if @prepends.nil?
          @prepends = [mod]
        else
          @prepends << mod
        end
      end

      def add_module(mod)
        if @modules.nil?
          @modules = [mod]
        else
          @modules << mod
        end
      end
        
      def add_method(name, method)
        raise "method name must be a symbol" unless name.class.equal?(Symbol)
        raise "method must be a method" unless method.class.equal?(Method) # TODO
      end

      # TODO - private/public
      def find_method(name)
        puts "Looking in class #{@name} for method #{name}"
        puts "  methods #{@methods}"
        # 1. Prepended modules
        unless @prepends.nil?
          # TODO check forwards or reverse order here - I _think_ it's forwards which is counter-intuituve
          @prepends.each do |mod|
            method = mod.find_method(name)
            return method unless method.nil?
          end
        end

        # 2. This class's methods
        method = @methods[name]
        return method unless method.nil?

        # 3. Module methods
        unless @modules.nil?
          @modules.each do |mod|
            method = mod.find_method(name)
            return method unless method.nil?
          end
        end

        # 4. Superclass
        unless @superclass.nil?
          method = @superclass.find_method(name)
          return method unless method.nil?
        end

        # 5.fail - missing_method and raise are done by the VM
        nil
      end
    end
  end
end
