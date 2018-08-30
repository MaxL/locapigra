class AddChapterNumberToWebcomicChapters < ActiveRecord::Migration
  def change
    add_column :webcomic_chapters, :chapter_number, :integer, unique: true
  end
end
