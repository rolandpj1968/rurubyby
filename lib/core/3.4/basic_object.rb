class BasicObject
  # TODO - I suspect we'll need to establish separate Rurubyby classes for any ruby class that requires intrinsics
  #   Specifically between BasicObject, Kernel and Object

  def __id__ = __intrinsic__('::Rurubyby::Vm::ObjectObject', :rurubyby___id__, self)

  def ! = __intrinsic__('::Rurubyby::Vm::ObjectObject', :rurubyby__not_, self)

  def equal?(v) = __intrinsic__('::Rurubyby::Vm::ObjectObject', :rurubyby_equal?, self, v)

  # TODO - not sure if this and equal? are entirely separate in ruby semantics
  def ==(v) = __intrinsic__('::Rurubyby::Vm::ObjectObject', :rurubyby__equals_equals_, self, v)
end
