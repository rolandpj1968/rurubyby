module Rurubyby
  module Vm
    module Intrinsics
      class << self
        def bool_object_for(bool) = bool ? TrueObject::TRUE : FalseObject::FALSE

        # BasicObject
        def basic_object___id__(v) = v.__id__

        def basic_object__equal_equal_(v1, v2) = bool_object_for(v1.equal?(v2))

        def basic_object__not_equal_(v1, v2) = bool_object_for(!v1.equal?(v2))

        # Integer
        def integer__leq_(v1, v2)
          #raise "BUG: Integer <= intrinsic must be called with Integer values" unless v1.class.equal?(IntegerObject) and v2.class.equal?(IntegerObject)
          bool_object_for(v1.value <= v2.value)
        end

        def integer__plus_(v1, v2)
          #raise "BUG: Integer + intrinsic must be called with Integer values" unless v1.class.equal?(IntegerObject) and v2.class.equal?(IntegerObject)
          IntegerObject.new(v1.value + v2.value)
        end

        def integer__minus_(v1, v2)
          #raise "BUG: Integer + intrinsic must be called with Integer values" unless v1.class.equal?(IntegerObject) and v2.class.equal?(IntegerObject)
          IntegerObject.new(v1.value - v2.value)
        end
      end
    end
  end
end
