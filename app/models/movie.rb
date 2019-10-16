class Movie < ApplicationRecord

  validates :title, :released_on, :duration, presence: true
  validates :description, length: {minimum: 25}
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}
  validates :slug, uniqueness: true
  validates :image_file_name, allow_blank: true, format: {
    with:   /\w+\.(gif|jpe?g|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  before_validation :generate_slug

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where("released_on <= ?", Time.now).order("released_on desc") }
  scope :unreleased, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(max=3) { released.limit(max) }
  scope :hits, -> {where('total_gross >= 300000000').order(total_gross: :desc)}
  scope :flops, -> {where('total_gross < 50000000').order(total_gross: :asc)}

  def self.recently_added
    order('created_at desc').limit(3)
  end

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def average_stars
    reviews.average(:stars)
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= [title.parameterize, released_on.year].join("-")
  end
end
