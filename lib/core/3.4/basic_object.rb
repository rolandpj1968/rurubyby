class BasicObject
  def __id__ = Intrinsics.basic_object___id__(self)

  def ! = false.equal?(self) || nil.equal?(self)

  def ==(v) = Intrinsics.basic_object__equal_equal_(self, v)
  def equal?(v) = Intrinsics.basic_object__equal_equal_(self, v)
  # TODO
  # alias == eql?
  # alias equal? eql?

  def !=(v) = !(self == v)

  # TODO
  # __send__
  # instance_eval
  # instance_exec
end
