class Image < ActiveRecord::Base
  belongs_to :comic

  validates :comic, presence: true

  mount_uploader :path, ComicImageUploader
end
