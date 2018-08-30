class WebcomicChapter < ActiveRecord::Base
  belongs_to :webcomic
  has_many :webcomic_pages

  accepts_nested_attributes_for :webcomic_pages, allow_destroy: true
end
