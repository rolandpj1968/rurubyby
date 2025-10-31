require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class NilObject < ObjectObject
      def initialize
        super(Core::NIL_CLASS_CLASS)
      end

      def to_s = "nil"

      NIL_OBJECT = new
    end
  end
end

