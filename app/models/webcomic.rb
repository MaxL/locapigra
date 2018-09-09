class Webcomic < ActiveRecord::Base
  #has_many :webcomic_pages
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  has_many :webcomic_pages, :dependent => :destroy
  has_many :webcomic_chapters
  accepts_nested_attributes_for :webcomic_pages, allow_destroy: true

  mount_uploader :title_image, TitleImageUploader
end
