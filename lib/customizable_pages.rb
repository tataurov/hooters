module CustomizablePages
  module ClassMethods
    # Public: execute configuration methods
    # Returns nothing
    def configure(&block)
      @@pages = []

      add_default
      yield(self) if block_given?
    end

    # Public: add PathOptions instance to pages collection
    # Returns nothing
    def add(controller_action, options = {})
      @@pages.push(PathOptions.new(controller_action, options))
    end

    # Public getter of pages class variable
    # Returns Array
    def all
      @@pages
    end

    # Public: find all PathOptions without saved PageSettings
    # Returns Array
    def without_page_settings
      pages_controller_actions = all.map(&:controller_action) - PageSettings.all.map(&:controller_action_name)
      all.select { |p| pages_controller_actions.include?(p.controller_action) }
    end

    # Public: Find PathOptions with specified controller_action attribute
    # Returns PathOptions instance
    def find_by_controller_action(controller_action)
      all.find { |p| p.controller_action == controller_action }
    end

    protected

    # Internal: adds PathOptions instance to pages array with default settings
    # Returns nothing
    def add_default
      add(ProjectRoutes::DEFAULT_OPTIONS_ID)
    end
  end
  extend ClassMethods

  class PathOptions
    attr_accessor :controller, :action, :controller_action, :path, :keywords, :variables, :disabled_fields

    def initialize(controller_action, options = {})
      cn = controller_action.split('#')
      @controller, @action, @controller_action = cn.first, cn.last, controller_action
      @path = default? ? PageSettings::DEFAULT : ProjectRoutes.get_route_path(@controller, @action)
      @disabled_fields = options[:exclude_fields] || []
      @variables = options[:variables] || []
    end

    # Public: check - is path options default
    # Returns Boolean
    def default?
      controller_action == ProjectRoutes::DEFAULT_OPTIONS_ID
    end

    # Public: check - is field enabled
    # Params:
    #   - field: symbol
    # Returns Boolean
    def field_enabled?(field)
      !disabled_fields.include?(field)
    end
  end
end


#TODO: replace to initializer
unless Rails.env.test?
  CustomizablePages.configure do |config|
    config.add 'root#index'
    config.add 'advices#index'
    config.add 'advices#show', variables: [:title, :keywords, :description]
    config.add 'messages#new'
    config.add 'offers#index'
    config.add 'pages#about'
    config.add 'pages#loyalty'
    config.add 'pages#store_locator'
    config.add 'pharmacies#show',
               exclude_fields: [:header, :snippet],
               variables: [:title, :opening_hours, :phone_number, :keywords, :address, :chemist]
    config.add 'services#index'
    config.add 'maps#show'
  end
end
