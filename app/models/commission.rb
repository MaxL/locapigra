class Commission < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  has_many :commission_images, :dependent => :destroy
  accepts_nested_attributes_for :commission_images, allow_destroy: true
end
