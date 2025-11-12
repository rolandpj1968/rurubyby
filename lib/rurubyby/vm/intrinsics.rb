module Rurubyby
  module Vm
    module Intrinsics
      StrictTypes = true

      class << self
        def bool_object_for(bool) = bool ? TrueObject::TRUE : FalseObject::FALSE

        # BasicObject
        def basic_object___id__(v) = v.__id__

        def basic_object__equal_equal_(v1, v2) = bool_object_for(v1.equal?(v2))

        def basic_object__not_equal_(v1, v2) = bool_object_for(!v1.equal?(v2))

        # Integer
        def is_int(v) = v.class.equal?(IntegerObject)

        def check_int_bin_args(op) = ("raise 'BUG: Integer #{op} intrinsic called with non-Integer values' unless is_int(v1) and is_int(v2)" if StrictTypes)

        def def_int_cmp(name, op) = eval "def int_#{name}(v1, v2); #{check_int_bin_args(op)}; bool_object_for(v1.value #{op} v2.value); end"

        def def_int_bin_op(name, op) = eval "def int_#{name}(v1, v2); #{check_int_bin_args(op)}; IntegerObject.new(v1.value #{op} v2.value); end"
      end

      # Integer
      def_int_cmp('_leq_', '<=')

      def_int_bin_op('_plus_', '+')
      def_int_bin_op('_minus_', '-')
    end
  end
end
