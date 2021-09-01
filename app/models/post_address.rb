class PostAddress
  include ActiveModel::Model
  attr_accessor :map_link, :distance, :course, :slope, :traffic, :crowd, :view, :comment, :user_id, :postal_code, :prefecture_code, :city, :street

  with_options presence: true do
    validates :map_link,
              format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/,
                        message: 'はhttpもしくはhttpsで始まるURLで入力してください' }
    validates :distance, numericality: { greater_than: 0 }
    validates :course
    validates :slope
    validates :traffic
    validates :crowd
    validates :view
    validates :comment, length: { maximum: 140 }
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{7}\z/ }
    validates :prefecture_code
    validates :city
    validates :street
  end

  def save
    post = Post.create(map_link: map_link, distance: distance, course: course, slope: slope, traffic: traffic, crowd: crowd, view: view, comment: comment, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_code: prefecture_code, city: city, street: street, post_id: post.id)
  end
end