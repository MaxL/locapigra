class Comic < ActiveRecord::Base
  resourcify
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  belongs_to :product
  has_many :images, :inverse_of => :comic, :dependent => :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  mount_uploader :cover_image, ComicImageUploader

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true#, length: { minimum: 150 }
  validates :pages, presence: true, numericality: true
  validates :cover, presence: true, length: { maximum: 255 }
  #validates :cover_image, presence: true
  validates :color, presence: true, length: { maximum: 255 }
  validates :dimensions, presence: true, length: { maximum: 255 }
  validates :slug, uniqueness: true
  validates :position, uniqueness: true, numericality: true, presence: true
  validate  :cover_image_size

  private

    def cover_image_size
      if cover_image.size > 10.megabytes
        errors.add(:cover_image, "should be less than 10MB")
      end
    end
end
