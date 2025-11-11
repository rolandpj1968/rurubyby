class BasicObject
  def __id__    = Intrinsics.basic_object___id__(self)

  def !         = false.equal?(self) || nil.equal?(self)

  def equal?(v) = Intrinsics.basic_object_equal?(self, v)
end
