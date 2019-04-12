class CommissionImage < ActiveRecord::Base
  resourcify
  belongs_to :commission

  validates :commission, presence: true

  mount_uploader :path, ComicImageUploader
end
