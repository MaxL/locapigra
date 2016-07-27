class Product < ActiveRecord::Base
  resourcify
  has_many :order_items
  has_many :product_images
  belongs_to :order

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :cover_image, ProductImageUploader

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true#, length: { minimum: 150 }
  validates :meta_title, presence: true#, length: { minimum: 15, maximum: 43 }
  validates :meta_description, presence: true#, length: { minimum: 120, maximum: 160 }
  validates :cover_image, presence: true
  validate  :cover_image_size
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 9999 }
  validates :taxrate, presence: true, numericality: true
  validates :weight, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 10 }
  validates :quantity, presence: true, numericality: true
  validates :package, presence: true, length: { maximum: 255 }
  validates :slug, uniqueness: true
  #validates :release_date, presence: true
  validates :language, presence: true
  validates_inclusion_of :active, :in => [ true, false ]

  default_scope { where(active: true) }

  private

    def cover_image_size
      if cover_image.size > 10.megabytes
        errors.add(:cover_image, "should be less than 10MB")
      end
    end
end
