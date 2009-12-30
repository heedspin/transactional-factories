class Test::Unit::TestCase
  class << self
    def suite
      method_names = public_instance_methods(true)
      tests = method_names.delete_if {|method_name| method_name !~ /^test./}
      suite = TransactionalFactories::TestSuite.new(name)
      tests.sort.each do
        |test|
        catch(:invalid_test) do
          suite << new(test)
        end
      end
      if (suite.empty?)
        catch(:invalid_test) do
          suite << new("default_test")
        end
      end
      return suite
    end
  end
end
