module Rurubyby
  module Vm
    module Intrinsics
      class << self
        # BasicObject

        def basic_object___id__(v) = v.__id__

        def basic_object__equal_equal_(v1, v2) = v1.equal?(v2)

        def basic_object__not_equal_(v1, v2) = !v1.equal?(v2)
      end
    end
  end
end
