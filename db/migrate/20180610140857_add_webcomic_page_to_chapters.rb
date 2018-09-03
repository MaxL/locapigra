class AddWebcomicPageToChapters < ActiveRecord::Migration[4.2]
  def change
    add_reference :webcomic_chapters, :webcomic_page, index: true, foreign_key: true
  end
end
