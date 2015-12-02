class Girl < ActiveRecord::Base
  has_many :gallery_items, dependent: :destroy
end