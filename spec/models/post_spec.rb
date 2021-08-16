require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '新規投稿機能' do
    context '新規投稿ができる時' do
      it '画像以外が存在すれば登録できること' do
        @post.image = nil
        expect(@post).to be_valid
      end
    end

    context '新規投稿ができない時' do
      it 'map_linkが空では登録できないこと' do
        @post.map_link = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Map link can't be blank")
      end

      it 'map_linkはhttpもしくはhttpsで始まるURLでしか登録できないこと' do
        @post.map_link = 'www.google.com'
        @post.valid?
        expect(@post.errors.full_messages).to include('Map link is invalid. Input URL.')
      end

      it 'distanceが空では登録できないこと' do
        @post.distance = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Distance can't be blank")
      end

      it 'distanceが0km以下の場合は保存できないこと' do
        @post.distance = -5
        @post.valid?
        expect(@post.errors.full_messages).to include('Distance must be greater than 0')
      end

      it 'distanceが全角文字では登録できないこと' do
        @post.distance = '５'
        @post.valid?
        expect(@post.errors.full_messages).to include('Distance is not a number')
      end

      it 'distanceが英数字混合では登録できないこと' do
        @post.distance = '5a'
        @post.valid?
        expect(@post.errors.full_messages).to include('Distance is not a number')
      end

      it 'distanceが半角英字では登録できないこと' do
        @post.distance = 'aa'
        @post.valid?
        expect(@post.errors.full_messages).to include('Distance is not a number')
      end

      it 'courseが空では登録できないこと' do
        @post.course = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Course can't be blank")
      end

      it 'slopeが空では登録できないこと' do
        @post.slope = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Slope can't be blank")
      end

      it 'trafficが空では登録できないこと' do
        @post.traffic = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Traffic can't be blank")
      end

      it 'crowdが空では登録できないこと' do
        @post.crowd = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Crowd can't be blank")
      end

      it 'viewが空では登録できないこと' do
        @post.view = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("View can't be blank")
      end

      it 'commentが空では登録できないこと' do
        @post.comment = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Comment can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
