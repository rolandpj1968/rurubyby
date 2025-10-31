require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class FalseObject < ObjectObject
      def initialize
        super(Core::FALSE_CLASS_CLASS)
      end

      def to_s = "false"

      FALSE_OBJECT = new
    end
  end
end

