module Rurubyby
  module Vm
    class Frame
      def initialize(the_self, locals, scopes)
        # TODO - map locals to slot number
        @locals = {}
        locals.each do |local|
          @locals[local] = NilObject::NIL_OBJECT
        end
        @the_self = the_self
        @scope = scope
      end

      def the_self = @the_self

      def get_local(local) = @locals[local]

      def set_local(local, value)
        @locals[local] = value
      end

      def scope = @scope
    end
  end
end
