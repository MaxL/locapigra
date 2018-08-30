class AddWebcomicPageToChapters < ActiveRecord::Migration
  def change
    add_reference :webcomic_chapters, :webcomic_page, index: true, foreign_key: true
  end
end
