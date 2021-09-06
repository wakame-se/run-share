class PostAddress
  include ActiveModel::Model
  attr_accessor :map_link, :distance, :course, :slope, :traffic, :crowd, :view, :comment, :image, :user_id,
                :postal_code, :prefecture_code, :city, :street

  with_options presence: true do
    validates :map_link,
              format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/,
                        message: 'はhttpもしくはhttpsで始まるURLで入力してください' }
    validates :postal_code, format: { with: /\A[0-9]{7}\z/, message: 'は数値のみで入力してください' }
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
    if !attribute[:id].nil?
      @post = Post.find(attribute[:id])
      @address = @post.address
      self.map_link = if !(self.map_link = attribute[:map_link])
                        @post.map_link
                      else
                        attribute[:map_link]
                      end
      self.distance = if !(self.distance = attribute[:distance])
                        @post.distance
                      else
                        attribute[:distance]
                      end
      self.course = if !(self.course = attribute[:course])
                      @post.course
                    else
                      attribute[:course]
                    end
      self.slope = if !(self.slope = attribute[:slope])
                     @post.slope
                   else
                     attribute[:slope]
                   end
      self.traffic = if !(self.traffic = attribute[:traffic])
                       @post.traffic
                     else
                       attribute[:traffic]
                     end
      self.crowd = if !(self.crowd = attribute[:crowd])
                     @post.crowd
                   else
                     attribute[:crowd]
                   end
      self.view = if !(self.view = attribute[:view])
                    @post.view
                  else
                    attribute[:view]
                  end
      self.comment = if !(self.comment = attribute[:comment])
                       @post.comment
                     else
                       attribute[:comment]
                     end
      self.image = if !(self.image = attribute[:image])
                     @post.image
                   else
                     attribute[:image]
                   end
      self.user_id = if !(self.user_id = attribute[:user_id])
                       @post.user_id
                     else
                       attribute[:user_id]
                     end
      self.postal_code = if !(self.postal_code = attribute[:postal_code])
                           @address.postal_code
                         else
                           attribute[:postal_code]
                         end
      self.prefecture_code = if !(self.prefecture_code = attribute[:prefecture_code])
                               @address.prefecture_code
                             else
                               attribute[:prefecture_code]
                             end
      self.city = if !(self.city = attribute[:city])
                    @address.city
                  else
                    attribute[:city]
                  end
      self.street = if !(self.street = attribute[:street])
                      @address.street
                    else
                      attribute[:street]
                    end
    else
      super(attribute)
    end
  end

  def persisted?
    if @post.nil?
      false
    else
      @post.persisted?
    end
  end

  def save
    post = Post.create(map_link: map_link, distance: distance, course: course, slope: slope, traffic: traffic,
                       crowd: crowd, view: view, comment: comment, image: image, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_code: prefecture_code, city: city, street: street,
                   post_id: post.id)
  end

  def update
    @post.update(map_link: map_link, image: image, distance: distance, course: course, slope: slope, traffic: traffic,
                 crowd: crowd, view: view, comment: comment, user_id: user_id)
    @address.update(postal_code: postal_code, prefecture_code: prefecture_code, city: city, street: street)
  end
end
