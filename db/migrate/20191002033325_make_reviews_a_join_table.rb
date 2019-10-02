class MakeReviewsAJoinTable < ActiveRecord::Migration[5.1]
  def up
    Review.delete_all
    remove_column :reviews, :name
    remove_column :reviews, :email
    add_column :reviews, :user_id, :integer
  end

  def down
    Review.delete_all
    remove_column :reviews, :user_id
    add_column :reviews, :name, :string
    add_column :reviews, :email, :string
  end
end
