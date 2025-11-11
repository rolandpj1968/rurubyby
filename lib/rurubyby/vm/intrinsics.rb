module Rurubyby
  module Vm
    module Intrinsics
      class << self
        # BasicObject

        def basic_object___id__(v) = v.__id__

        def basic_object_equal?(v1, v2) = v1.equal?(v2)
      end
    end
  end
end
