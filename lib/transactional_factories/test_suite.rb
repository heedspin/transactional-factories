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
      if @tests.any? { |testcase| testcase.method_name != 'default_test' }
        ActiveRecord::Base.transaction(:requires_new => true) do
          testcase.class.setup if testcase
          begin
            yield(STARTED, name)
            @tests.each do |test|
              ActiveRecord::Base.transaction(:requires_new => true) do
                test.run(result, &progress_block)
                raise ActiveRecord::Rollback
              end
            end
            yield(FINISHED, name)
          rescue
            raise $!
          ensure
            testcase.class.teardown if testcase.class.respond_to?(:teardown)
          end
          Timecop.return if defined?(Timecop)
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end
