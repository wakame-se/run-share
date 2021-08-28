class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters.' } do
      validates :last_name_reading
      validates :first_name_reading
    end
    validates :birthday
  end
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is invalid. Input half-width characters.' }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end
end
