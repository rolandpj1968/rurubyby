module Rurubyby
  module Vm
    class StackFrame
      # TODO - array for StackFrame's rather than linked list?
      def initialize(parent, the_self, locals)
        raise "parent frame must be a StackFrame" unless parent.nil? || parent.class.equal?(StackFrame)
        raise "locals must be an array" unless locals.class.equal?(Array)

        @parent = parent
        @the_self = the_self
        # TODO - pre-calculate slot numbers and use an array
        @locals = {}

        locals.each do |local|
          raise "local must be a symbol" unless local.class.equal?(Symbol)
          @locals[local] = NilObject::NIL_OBJECT
        end
      end

      def the_self = @the_self

      def get_local(local) = @locals[local]

      def set_local(local, val)
        @locals[local] = val
      end
    end
  end
end
