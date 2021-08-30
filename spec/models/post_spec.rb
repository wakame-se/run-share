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
        expect(@post.errors.full_messages).to include("Map共有リンクを入力してください")
      end

      it 'map_linkはhttpもしくはhttpsで始まるURLでしか登録できないこと' do
        @post.map_link = 'www.google.com'
        @post.valid?
        expect(@post.errors.full_messages).to include('Map共有リンクはhttpもしくはhttpsで始まるURLで入力してください')
      end

      it 'distanceが空では登録できないこと' do
        @post.distance = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("距離を入力してください")
      end

      it 'distanceが0km以下の場合は保存できないこと' do
        @post.distance = -5
        @post.valid?
        expect(@post.errors.full_messages).to include('距離は0より大きい値にしてください')
      end

      it 'distanceが全角文字では登録できないこと' do
        @post.distance = '５'
        @post.valid?
        expect(@post.errors.full_messages).to include('距離は数値で入力してください')
      end

      it 'distanceが英数字混合では登録できないこと' do
        @post.distance = '5a'
        @post.valid?
        expect(@post.errors.full_messages).to include('距離は数値で入力してください')
      end

      it 'distanceが半角英字では登録できないこと' do
        @post.distance = 'aa'
        @post.valid?
        expect(@post.errors.full_messages).to include('距離は数値で入力してください')
      end

      it 'courseが空では登録できないこと' do
        @post.course = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("山コース or 海コースを入力してください")
      end

      it 'slopeが空では登録できないこと' do
        @post.slope = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("坂の多さを入力してください")
      end

      it 'trafficが空では登録できないこと' do
        @post.traffic = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("交通量を入力してください")
      end

      it 'crowdが空では登録できないこと' do
        @post.crowd = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("人混みを入力してください")
      end

      it 'viewが空では登録できないこと' do
        @post.view = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("景色を入力してください")
      end

      it 'commentが空では登録できないこと' do
        @post.comment = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("コメントを入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
