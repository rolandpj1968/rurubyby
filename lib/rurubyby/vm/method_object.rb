require_relative 'core'
require_relative 'object'

module Rurubyby
  module Vm
    class MethodObject < Object
      def initialize(value)
        raise "IntegerObject must have an Integer value" unless value.class.equal?(Integer)

        super(Core::INTEGER_CLASS)

        @value = value
      end
    end
  end
end
