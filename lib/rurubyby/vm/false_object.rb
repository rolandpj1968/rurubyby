require_relative 'core'
require_relative 'object'

module Rurubyby
  module Vm
    class FalseObject < Object
      def initialize
        super(Core::FALSE_CLASS_CLASS)
      end

      def to_s = false

      FALSE_OBJECT = new
    end
  end
end

