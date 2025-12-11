module Rurubyby
  module Ast
    class MethodCall
      def initialize(name, receiver_node, arg_nodes)
        raise "name must be a Symbol" unless name.class.equal?(Symbol)
        @name = name
        @receiver_node = receiver_node # nil if no explicit receiver
        @arg_nodes = arg_nodes
        @cached_epoch = nil
        @cached_receiver = nil
        @cached_method = nil
      end

      def to_s
        "call(#{@name}, #{@receiver_node || '_'}, #{@arg_nodes.map(&:to_s).join(', ')})"
      end

      def execute(context)
        #puts "          RPJ = MethodCall#execute method :#{@name} receiver #{@receiver_node}"
        receiver =
          if @receiver_node.nil?
            context.frame.the_self
          else
            @receiver_node.execute(context)
          end

        args = @arg_nodes.map { |arg_node| arg_node.execute(context) }

        vm = context.vm
        vm.count_method_call

        # TODO - arm waving around thread safety
        current_epoch = vm.epoch
        
        #puts "cached @epoch for call to #{@name} is #{@cached_epoch} - current_epoch is #{current_epoch}"

        if vm.cache_method_calls &&
           (
             # same epoch - no new methods defined since last time, and ...
             current_epoch.equal?(@cached_epoch) &&
             (
               # ... same object as last time, or
               receiver.equal?(@cached_receiver) ||
               # ... same class as last time, and no singleton methods involved
               (
                 receiver.class_object.equal?(@cached_receiver.class_object) &&
                 !receiver.singleton_methods? &&
                 !@cached_receiver.singleton_methods?
               )
             )
           )
          method = @cached_method
        else
          vm.count_method_call_cache_miss
          
          method = receiver.lookup_method(@name)

          @cached_epoch = current_epoch
          @cached_receiver = receiver
          @cached_method = method
          # method_for(receiver)
          #puts "          RPJ = MethodCall#execute method :#{@name} receiver #{receiver.class}"
          #puts "          RPJ =    method found is #{method}"
          
          # TODO - this is a runtime exception, not an assert
          raise "method :#{@name} not found - not yet doing missing_method" if method.nil?
        end

        new_frame = Vm::Frame.new(receiver, method.locals, method.scopes)

        params = method.params

        # TODO - this is a runtime error, not an intrinsic error
        raise "wrong number of arguments (given #{args.length} expecting #{params.length})" if args.length != params.length

        params.length.times do |i|
          new_frame.set_local(params[i], args[i])
        end

        context.push_frame(new_frame)
        begin
          method.ast.execute(context)
        ensure
          context.pop_frame
        end
      end

      # def method_for(receiver)
      #   puts "last @class for call to #{@name} is #{@class&.name} class is now #{receiver.class_object.name}"
      #   puts "receiver has singleton methods? #{receiver.singleton_methods?}" # we need to do this better for class methods

      #   receiver.lookup_method(@name)
      # end
    end
  end
end
