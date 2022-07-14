require 'maria_call_center/log'

require 'dry-container'

module MariaCallCenter
  extend self

  def dependencies(container: Dry::Container.new, eagerly_initialize: true)
    # https://github.com/dry-rb/dry-container

    # require 'my_dependency_here'

    require 'maria_call_center/interactors/play_greeting'
    require 'maria_call_center/interactors/present_main_menu'
    require 'maria_call_center/interactors/present_sub_menu'
    require 'maria_call_center/interactors/request_tax_number'
    require 'maria_call_center/interactors/play_orders_message'
    require 'maria_call_center/interactors/play_payments_message'
    require 'maria_call_center/interactors/leave_message'
    require 'maria_call_center/interactors/dial_external_number'
    require 'maria_call_center/interactors/retrieve_agent'
    require 'maria_call_center/interactors/release_agent'
    require 'maria_call_center/repository/agent_repository'

    # When to use memoize?
    # Memoize should be used when registering thread-safe instances, so they
    # can be (and will be) reused by all threads. This means that you
    # **MUST NOT** add non-thread-safe instances as memoized instances, or there
    # will be fireworks.
    #
    # When instances have non-thread-safe internal state, we register instead
    # factory classes, which can be used to generate instances that will be
    # private to their creator.

    # register containers here

    container.register(:env) {
      ENV
    }

    container.register(:play_greeting, memoize: true) {
      Interactors::PlayGreeting.new(container)
    }
    container.register(:present_main_menu, memoize: true) {
      Interactors::PresentMainMenu.new(container)
    }
    container.register(:present_sub_menu, memoize: true) {
      Interactors::PresentSubMenu.new(container)
    }
    container.register(:request_tax_number, memoize: true) {
      Interactors::RequestTaxNumber.new(container)
    }
    container.register(:play_orders_message, memoize: true) {
      Interactors::PlayOrdersMessage.new(container)
    }
    container.register(:play_payments_message, memoize: true) {
      Interactors::PlayPaymentsMessage.new(container)
    }
    container.register(:leave_message, memoize: true) {
      Interactors::LeaveMessage.new(container)
    }
    container.register(:dial_external_number, memoize: true) {
      Interactors::DialExternalNumber.new(container)
    }
    container.register(:retrieve_agent, memoize: true) {
      Interactors::RetrieveAgent.new(container)
    }
    container.register(:release_agent, memoize: true) {
      Interactors::ReleaseAgent.new(container)
    }
    container.register(:agent_repository, memoize: true) {
      Repository::AgentRepository.new(container)
    }

    eagerly_initialize(container) if eagerly_initialize

    container
  end

  def eagerly_initialize(container)
    container.each_key do |dependency|
      container.resolve(dependency)
    end
  end
end
