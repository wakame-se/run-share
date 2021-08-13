class Post < ApplicationRecord
  with_options presence: true do
    validates :map_link, format: {with: /\A#{URI::regexp(%w(http https))}\z/, message: 'is invalid. Input URL.'}
    validates :distance, numericality: true
    validates :text
  end

  belongs_to :user
end
