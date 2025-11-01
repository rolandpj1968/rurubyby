# TODO - remove
require_relative '../vm/core'

module Rurubyby
  module Ast
    # TODO - dedup with hash
    class ConstantRead
      def initialize(name)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)

        @name = name
      end

      def to_s = "con(#{@name})"

      # TODO hack for now - we need lexical scope
      def execute(context) = Vm::Core::OBJECT_CLASS.lookup_constant(@name)
    end
  end
end
