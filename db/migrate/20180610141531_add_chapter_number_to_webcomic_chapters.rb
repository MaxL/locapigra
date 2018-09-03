class AddChapterNumberToWebcomicChapters < ActiveRecord::Migration[4.2]
  def change
    add_column :webcomic_chapters, :chapter_number, :integer, unique: true
  end
end
