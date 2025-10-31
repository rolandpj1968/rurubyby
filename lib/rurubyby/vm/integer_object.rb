require_relative 'core'
require_relative 'object'

module Rurubyby
  module Vm
    class IntegerObject < Object
      def initialize(value)
        throw "IntegerObject must have an Integer value" unless value.class.equal?(Integer)
        super(Core::INTEGER_CLASS)
        @value = value
      end
    end
  end
end

