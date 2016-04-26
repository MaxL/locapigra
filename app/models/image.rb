class Image < ActiveRecord::Base
  resourcify
  belongs_to :comic

  validates :comic, presence: true

  mount_uploader :path, ComicImageUploader
end
