require_relative 'core'
require_relative 'object'

module Rurubyby
  module Vm
    class TrueObject < Object
      def initialize
        super(Core::TRUE_CLASS_CLASS)
      end

      TRUE_OBJECT = new
    end
  end
end

