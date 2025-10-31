require_relative 'core'
require_relative 'object_object'

module Rurubyby
  module Vm
    # Mmm, do we want to objectify this for all methods?
    class UnboundMethodObject < ObjectObject
      # TODO - default params, keyword params, block param
      def initialize(class_or_module_object, name, params, locals, ast)
        super(Core::UNBOUND_METHOD_CLASS)

        # TODO Module class _can_ be subclassed - unlike Class class
        unless class_or_module_object.class.equal?(ClassObject) || class_or_module_object.class.equal?(ModuleObject)
          raise "UnboundMethodObject class_or_module must be ClassObject or ModuleObject"
        end
        raise "name must be a Symbol" unless name.class.equal?(Symbol)
        # TODO - array of symbols
        raise "params must be an array of Symbols" unless params.class.equal?(Array)
        # TODO - array of symbols
        raise "locals must be an array of Symbols" unless locals.class.equal?(Array)

        @class_or_module_object = class_or_module_object
        @name = name
        @params = params
        @locals = locals
        @ast = ast
      end

      def locals = @locals

      # TODO default args, keyword args, block param
      def invoke(frame, args)
        # TODO - this is a runtime error, not an intrinsic error
        raise "wrong number of arguments (given #{args.length} expecting #{params.length})" if args.length < @params.length

        @params.length.times do |i|
          frame.set_local(@params[i], args[i])
        end

        @ast.eval(frame)
      end
    end
  end
end
