require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    class StringObject < ObjectObject
      def initialize(value)
        raise "StringObject must have an String value" unless value.class.equal?(String)

        super(Core::STRING_CLASS)

        @value = value
      end

      def to_s = @value
    end
  end
end

