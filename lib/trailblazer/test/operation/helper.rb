module Trailblazer::Test
  module Operation
    module Helper
      def call(operation_class, *args)
        call!(operation_class, args)
      end

      def call!(operation_class, args, raise_on_failure: false)
        operation_class.(*args).tap do |result|
          unless result.success?
            yield result if block_given?
            fail OperationFailedError, "factory( #{operation_class} ) failed." if raise_on_failure
          end
        end
      end

      def factory(operation_class, *args, &block)
        call!(operation_class, args, raise_on_failure: true, &block)
      end
    end
  end

  class OperationFailedError < RuntimeError
  end
end
