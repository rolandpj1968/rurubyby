module Rurubyby
  module Intrinsics
    module BasicObject
      class << self
        def ____id__(v) = v.__id__

        def ___not_(v) = (v.equal?(FalseObject::FALSE_OBJECT) || v.equal?(NilObject::NIL_OBJECT)) ? TrueObject::TRUE_OBJECT : FalseObject::FALSE_OBJECT

        def __equal?(v1, v2) = v1.__id__.equal?(v2.__id__)

        def ___equals_equals_(v1, v2) = v1.__id__.equal?(v2.__id__)
      end
    end
  end
end
