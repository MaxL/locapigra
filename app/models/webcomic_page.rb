class WebcomicPage < ActiveRecord::Base
  resourcify
  belongs_to :webcomic
  belongs_to :webcomic_chapter

  validates :webcomic, presence: true

  mount_uploader :path, ComicImageUploader
end
