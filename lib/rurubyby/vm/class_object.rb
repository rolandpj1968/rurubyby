#require_relative 'core'
require_relative 'module_object'

module Rurubyby
  module Vm
    class ClassObject < ModuleObject
      def initialize(name, namespace, superclass)
        super(name, namespace, Core.class_class)

        raise "superclass must be a ClassObject" unless superclass.nil? or superclass.class.equal?(ClassObject)

        @superclass = superclass
        @prepends = nil
        @modules = nil
      end

      # class "Class" circular depenency band-aid - see core.rb too
      def patch_class_object
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
        
      # TODO - private/public
      def lookup_method(name)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        # 1. Prepended modules
        unless @prepends.nil?
          # TODO check forwards or reverse order here - I _think_ it's forwards which is counter-intuituve
          @prepends.each do |mod|
            method = mod.get_method(name)
            return method unless method.nil?
          end
        end

        # 2. This class's methods
        method = get_method(name)
        return method unless method.nil?

        # 3. Module methods
        unless @modules.nil?
          @modules.each do |mod|
            method = mod.get_method(name)
            return method unless method.nil?
          end
        end

        # 4. Superclass
        unless @superclass.nil?
          method = @superclass.lookup_method(name)
          return method unless method.nil?
        end

        # 5.fail - missing_method and raise are done by the VM
        nil
      end

      def lookup_constant(name)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        # 1. Lexical scope - TODO brokken, see ModuleObject#lookup_constant_in_lexical_scope
        constant = lookup_constant_in_lexical_scope(name)
        return constant unless constant.nil?

        # 2. Class hierarchy
        constant = lookup_constant_in_hierarchy(name)
        return constant unless constant.nil?

        # 5.fail - missing_constant and raise are done by the VM
        nil
      end

      def lookup_constant_in_hierarchy(name)
        # 1. Prepended modules
        unless @prepends.nil?
          # TODO check forwards or reverse order here - I _think_ it's forwards which is counter-intuituve
          @prepends.each do |mod|
            constant = mod.get_constant(name)
            return constant unless constant.nil?
          end
        end

        # 2. This class's constants
        constant = get_constant(name)
        return constant unless constant.nil?

        # 3. Module constants
        unless @modules.nil?
          @modules.each do |mod|
            constant = mod.get_constant(name)
            return constant unless constant.nil?
          end
        end

        # 4. Superclass
        unless @superclass.nil?
          constant = @superclass.get_constant(name)
          return constant unless constant.nil?
        end

        # 5.fail - missing_constant and raise are done by the VM
        nil
      end
    end
  end
end
