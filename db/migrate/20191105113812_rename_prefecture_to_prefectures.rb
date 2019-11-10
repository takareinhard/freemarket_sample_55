class RenamePrefectureToPrefectures < ActiveRecord::Migration[5.0]
  def change
    rename_table :prefecture, :prefectures
  end
end
