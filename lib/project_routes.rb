class ProjectRoutes
  DEFAULT_OPTIONS_ID = [PageSettings::DEFAULT, PageSettings::DEFAULT].join('#')

  module ClassMethods
    # Internal: extract route path from route
    # route - ActionDispatch::Journey::Route instance
    # Returns String
    def get_route_path(controller, action)
      route = all_routes.select do |route|
        route.defaults[:controller] == controller.to_s &&
          route.defaults[:action] == action.to_s
      end.first

      return '/' if route.nil?

      ActionDispatch::Routing::RouteWrapper.new(route).path.sub!('(.:format)', '')  || '/'
    end

    def all_routes
      CareplusApi::Application.routes.routes
    end
  end

  extend ClassMethods
end
