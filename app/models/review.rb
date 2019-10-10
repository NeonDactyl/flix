class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

#validates :name, presence: true
#  validates :comment, length: { minimum: 4 }

  STARS = Array(1..5)

  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and 5"
  }


end
