require_relative 'module'
require_relative 'klass'

module Rurubyby
  module Vm
    module Core
      # TODO - parse these from source code

      BASIC_OBJECT_CLASS = Klass.new(:BasicObject, nil, nil)

      KERNEL_MODULE = Module.new(:Kernel, nil)
      
      OBJECT_CLASS = Klass.new(:Object, nil, BASIC_OBJECT_CLASS)
      OBJECT_CLASS.add_module(KERNEL_MODULE)

      MODULE_CLASS = Klass.new(:Module, nil, BASIC_OBJECT_CLASS)

      CLASS_CLASS = Klass.new(:Class, nil, MODULE_CLASS)

      COMPARABLE_MODULE = Module.new(:Comparable, nil)

      STRING_CLASS = Klass.new(:String, nil, OBJECT_CLASS)
      STRING_CLASS.add_module(COMPARABLE_MODULE)

      SYMBOL_CLASS = Klass.new(:Symbol, nil, OBJECT_CLASS)
      SYMBOL_CLASS.add_module(COMPARABLE_MODULE)

      NUMERIC_CLASS = Klass.new(:Numeric, nil, OBJECT_CLASS)
      NUMERIC_CLASS.add_module(COMPARABLE_MODULE)

      INTEGER_CLASS = Klass.new(:Integer, nil, NUMERIC_CLASS)

      FLOAT_CLASS = Klass.new(:Float, nil, NUMERIC_CLASS)

      ENUMERABLE_MODULE = Module.new(:Enumerable, nil)

      ARRAY_CLASS = Klass.new(:Array, nil, OBJECT_CLASS)
      ARRAY_CLASS.add_module(ENUMERABLE_MODULE)

      HASH_CLASS = Klass.new(:Hash, nil, OBJECT_CLASS)
      HASH_CLASS.add_module(ENUMERABLE_MODULE)
    end
  end
end
