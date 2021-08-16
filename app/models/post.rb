class Post < ApplicationRecord
  with_options presence: true do
    validates :map_link,
              format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/,
                        message: 'is invalid. Input URL.' }
    validates :distance, numericality: { greater_than: 0 }
    validates :course
    validates :slope
    validates :traffic
    validates :crowd
    validates :view
    validates :comment
  end

  belongs_to :user
  has_one_attached :image
end
