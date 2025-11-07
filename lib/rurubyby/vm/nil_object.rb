require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class NilObject < ObjectObject
      def initialize
        super(Core::NIL_CLASS_CLASS)
      end

      # Global singleton object
      private_class_method :new

      def to_s = "nil"

      NIL_OBJECT = new
    end
  end
end

