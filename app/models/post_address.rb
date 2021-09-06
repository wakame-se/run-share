class PostAddress
  include ActiveModel::Model
  attr_accessor :map_link, :distance, :course, :slope, :traffic, :crowd, :view, :comment, :image, :user_id, :postal_code, :prefecture_code, :city, :street

  with_options presence: true do
    validates :map_link,
              format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/,
                        message: 'はhttpもしくはhttpsで始まるURLで入力してください' }
    validates :postal_code, format: { with: /\A[0-9]{7}\z/ }
    validates :prefecture_code
    validates :city
    validates :street
    validates :distance, numericality: { greater_than: 0 }
    validates :course
    validates :slope
    validates :traffic
    validates :crowd
    validates :view
    validates :comment, length: { maximum: 140 }
    validates :user_id
  end

  def initialize(attribute = {})
    if !(attribute[:id] == nil)
      @post = Post.find(attribute[:id])
      @address = @post.address
      if !(self.map_link = attribute[:map_link])
        self.map_link = @post.map_link 
      else
        self.map_link = attribute[:map_link]
      end
      if !(self.distance = attribute[:distance])
        self.distance = @post.distance 
      else
        self.distance = attribute[:distance]
      end
      if !(self.course = attribute[:course])
        self.course = @post.course 
      else
        self.course = attribute[:course]
      end
      if !(self.slope = attribute[:slope])
        self.slope = @post.slope 
      else
        self.slope = attribute[:slope]
      end
      if !(self.traffic = attribute[:traffic])
        self.traffic = @post.traffic 
      else
        self.traffic = attribute[:traffic]
      end
      if !(self.crowd = attribute[:crowd])
        self.crowd = @post.crowd 
      else
        self.crowd = attribute[:crowd]
      end
      if !(self.view = attribute[:view])
        self.view = @post.view 
      else
        self.view = attribute[:view]
      end
      if !(self.comment = attribute[:comment])
        self.comment = @post.comment 
      else
        self.comment = attribute[:comment]
      end
      if !(self.image = attribute[:image])
        self.image = @post.image 
      else
        self.image = attribute[:image]
      end
      if !(self.user_id = attribute[:user_id])
        self.user_id = @post.user_id 
      else
        self.user_id = attribute[:user_id]
      end
      if !(self.postal_code = attribute[:postal_code])
        self.postal_code = @address.postal_code 
      else
        self.postal_code = attribute[:postal_code]
      end
      if !(self.prefecture_code = attribute[:prefecture_code])
        self.prefecture_code = @address.prefecture_code 
      else
        self.prefecture_code = attribute[:prefecture_code]
      end
      if !(self.city = attribute[:city])
        self.city = @address.city 
      else
        self.city = attribute[:city]
      end
      if !(self.street = attribute[:street])
        self.street = @address.street 
      else
        self.street = attribute[:street]
      end
    else
      super(attribute)
    end
  end

  def persisted?
    if @post.nil? 
      return false 
    else
      return @post.persisted?
    end
  end

  def save
    post = Post.create(map_link: map_link, distance: distance, course: course, slope: slope, traffic: traffic, crowd: crowd, view: view, comment: comment, image: image, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_code: prefecture_code, city: city, street: street, post_id: post.id)
  end

  def update
    @post.update(map_link: map_link, image: image, distance: distance, course: course, slope: slope, traffic: traffic, crowd: crowd, view: view, comment: comment, user_id: user_id)
    @address.update(postal_code: postal_code, prefecture_code: prefecture_code, city: city, street: street)
  end
end