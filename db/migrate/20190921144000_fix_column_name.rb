class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :content, :comment
  end
end
