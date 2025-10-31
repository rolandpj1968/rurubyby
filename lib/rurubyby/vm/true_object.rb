require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class TrueObject < ObjectObject
      def initialize
        super(Core::TRUE_CLASS_CLASS)
      end

      def to_s = "true"

      TRUE_OBJECT = new
    end
  end
end

