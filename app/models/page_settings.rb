class PageSettings < ActiveRecord::Base
  DEFAULT = 'default'.freeze

  attr_accessor :controller_action

  before_validation :fill_controller_action_attributes
  validate :check_controller_action
  validates_presence_of :title
  validates_presence_of :controller
  validates_presence_of :action

  # Public: load default page setting record
  # Returns PageSettings instance
  def self.default_settings
    where(controller: DEFAULT, action: DEFAULT).first
  end

  # Public: check if page settings are default
  # Returns Boolean
  def default?
    controller == DEFAULT && action == DEFAULT
  end

  def display_name
    return DEFAULT if default?
    ProjectRoutes.get_route_path(controller, action)
  end

  def controller_action_name
    [controller, action].join('#')
  end

  private

  # Internal: check for exists save page settings for current controller and action
  # Returns nothing
  def check_controller_action
    return unless self.class.where(controller: controller, action: action).where.not(id: id).exists?
    errors.add(:controller_action, I18n.t('activerecord.errors.models.page_settings.attributes.controller_action.taken'))
  end

  # Internal: create controller_action attribute shared by two controller and action
  # Returns nothing
  def fill_controller_action_attributes
    return if controller_action.blank?
    route = controller_action.split('#')
    self.controller, self.action = route.first, route.last
  end
end

