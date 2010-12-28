require 'test/unit'

module TransactionalFactories
  class TransactionalFixturesEnabled < Exception
  end
  class TestSuite < Test::Unit::TestSuite
    def run(result, &progress_block)
      if testcase = @tests.find { |tc| tc.class.respond_to?(:setup) }
        if testcase.class.respond_to?(:use_transactional_fixtures) and testcase.class.use_transactional_fixtures
          raise TransactionalFixturesEnabled, 'transactional-factories does not work with transactional fixtures.  Please set use_transactional_fixtures = false.'
        end
      end
      transaction_classes = testcase.class.transaction_classes if testcase.class.respond_to?(:transaction_classes)
      unless transaction_classes.nil? or transaction_classes.is_a?(Enumerable)
        transaction_classes = [transaction_classes]
      end
      transaction_classes ||= [ActiveRecord::Base]

      if @tests.any? { |testcase| testcase.method_name != 'default_test' }
        run_rollback_transactions(transaction_classes) do
          testcase.class.setup if testcase
          begin
            yield(STARTED, name)
            @tests.each do |test|
              run_rollback_transactions(transaction_classes)  do
                test.run(result, &progress_block)
              end
            end
            yield(FINISHED, name)
          rescue
            raise $!
          ensure
            testcase.class.teardown if testcase.class.respond_to?(:teardown)
          end
          Timecop.return if defined?(Timecop)
        end
      end
    end

    # Recursively setup transactions that roll back...
    def run_rollback_transactions(transaction_classes, &block)
      transaction_classes.first.transaction(:requires_new => true) do
        if transaction_classes.size <= 1
          yield
        else
          run_rollback_transactions(transaction_classes[1..transaction_classes.size-1], &block)
        end
        raise ActiveRecord::Rollback
      end
    end
  end
end
