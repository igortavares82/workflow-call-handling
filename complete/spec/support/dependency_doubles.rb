# Simple helper to avoid having explicit dependencies on individual specs, but
# still take advantage of rspec's instance_doubles

# The idea is that this class is to be the test-time equivalent of the System
# container in config/boot.rb, but returning instance doubles instead of
# instances.

# To avoid slowing down execution, we only require the dependencies as they are
# needed.
module MariaCallCenter
  module Support
    module DependencyDoubles
      DEPENDENCIES = {

        # Example of a dependency declaration, :class & :instance

        # my_interactor: {
        #   name:    'MariaCallCenter::Interactors::MyInteractor',
        #   require: 'maria_call_center/interactors/my_interactor',
        #   type:    :instance,
        # },
        # my_factory: {
        #   name:    'MariaCallCenter::MyFactory',
        #   require: 'maria_call_center/my_factory',
        #   type:    :class,
        # },
      }.freeze

      def dependency_double(name, **args)
        known_dependency = DEPENDENCIES[name]

        if known_dependency
          require known_dependency.fetch(:require)
          name = known_dependency.fetch(:name)

          case known_dependency.fetch(:type)
          when :instance
            instance_double(name, **args)
          when :class
            class_double(name, **args)
          end
        else
          require 'colorized_string' # It's only ok to lazy require in specs. And stay in school, kids.

          puts ColorizedString["WARNING: Creating double for unknown dependency #{name.inspect}"].colorize(:red)
          instance_double(name.to_s, **args)
        end
      end
    end
  end
end

RSpec.configure do |conf|
  conf.include MariaCallCenter::Support::DependencyDoubles
end
