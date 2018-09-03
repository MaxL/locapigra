class AddChapterIdToWebcomicPage < ActiveRecord::Migration[4.2]
  def change
    add_reference :webcomic_pages, :webcomic_chapter, index: true, foreign_key: true
  end
end
