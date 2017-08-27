class WebcomicPage < ActiveRecord::Base
  resourcify
  belongs_to :webcomic

  validates :webcomic, presence: true

  mount_uploader :path, ComicImageUploader
end
