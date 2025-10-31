require_relative 'klass'

module Rurubyby
  module Vm
    # TODO we'll not need a specific class once we parse core .rb
    class IntegerClass < Klass
      # include supported methods here
      def initialize
        super("Integer", nil, Klass::THE_OBJECT_CLASS)
      end

      THE_INTEGER_CLASS = new
    end
  end
end
