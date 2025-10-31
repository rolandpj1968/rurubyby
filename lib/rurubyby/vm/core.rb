module Rurubyby
  module Vm
    module Core
      def self.class_class = nil
    end
  end
end

require_relative 'class_object'

module Rurubyby
  module Vm
    module Core
      BASIC_OBJECT_CLASS = ClassObject.new(:BasicObject, nil, nil)

      MODULE_CLASS = ClassObject.new(:Module, nil, BASIC_OBJECT_CLASS)

      CLASS_CLASS = ClassObject.new(:Class, nil, MODULE_CLASS)

      def self.class_class = CLASS_CLASS

      BASIC_OBJECT_CLASS.patch_class_object
      MODULE_CLASS.patch_class_object
      CLASS_CLASS.patch_class_object
    end
  end
end

require_relative 'module_object'

module Rurubyby
  module Vm
    module Core
      # TODO - parse these from source code

      KERNEL_MODULE = ModuleObject.new(:Kernel, nil)
      
      OBJECT_CLASS = ClassObject.new(:Object, nil, BASIC_OBJECT_CLASS)
      OBJECT_CLASS.add_module(KERNEL_MODULE)

      UNBOUND_METHOD_CLASS = ClassObject.new(:UnboundMethod, nil, OBJECT_CLASS)

      # I think we can only start parsing source code from here...

      NIL_CLASS_CLASS = ClassObject.new(:NilClass, nil, OBJECT_CLASS)

      COMPARABLE_MODULE = ModuleObject.new(:Comparable, nil)

      TRUE_CLASS_CLASS = ClassObject.new(:TrueClass, nil, OBJECT_CLASS)

      FALSE_CLASS_CLASS = ClassObject.new(:FalseClass, nil, OBJECT_CLASS)

      STRING_CLASS = ClassObject.new(:String, nil, OBJECT_CLASS)
      STRING_CLASS.add_module(COMPARABLE_MODULE)

      SYMBOL_CLASS = ClassObject.new(:Symbol, nil, OBJECT_CLASS)
      SYMBOL_CLASS.add_module(COMPARABLE_MODULE)

      NUMERIC_CLASS = ClassObject.new(:Numeric, nil, OBJECT_CLASS)
      NUMERIC_CLASS.add_module(COMPARABLE_MODULE)

      INTEGER_CLASS = ClassObject.new(:Integer, nil, NUMERIC_CLASS)

      FLOAT_CLASS = ClassObject.new(:Float, nil, NUMERIC_CLASS)

      ENUMERABLE_MODULE = ModuleObject.new(:Enumerable, nil)

      ARRAY_CLASS = ClassObject.new(:Array, nil, OBJECT_CLASS)
      ARRAY_CLASS.add_module(ENUMERABLE_MODULE)

      HASH_CLASS = ClassObject.new(:Hash, nil, OBJECT_CLASS)
      HASH_CLASS.add_module(ENUMERABLE_MODULE)
    end
  end
end
