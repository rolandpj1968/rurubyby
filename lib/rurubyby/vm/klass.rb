module Rurubyby
  module Vm
    class Klass < Module
      def initialize(name, namespace, superclass)
        super(name, namespace)
        raise "superclass must be a class" unless superclass.nil? or superclass.klass.equal?(Klass)
        @superclass = superclass
        @prepends = nil
        @modules = nil
      end

      def find_method(name)
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
        unless modules.nil?
          modules.each do |mod|
            method = mod.find_method(name)
            return method unless method.nil?
          end
        end

        # 4. Superclass
        unless superclass.nil?
          method = superclass.find_method(name)
          return method unless method.nil?
        end

        # 5.fail - missing_method and raise are done by the VM
        nil
      end
    end
  end
end
