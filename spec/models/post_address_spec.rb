require 'rails_helper'

RSpec.describe PostAddress, type: :model do
  before do
    @post_address = FactoryBot.build(:post_address)
  end

  describe '新規投稿機能' do
    context '新規投稿ができる時' do
      it '画像以外が存在すれば登録できること' do
        @post_address.image = nil
        expect(@post_address).to be_valid
      end
    end

    context '新規投稿ができない時' do
      it 'map_linkが空では登録できないこと' do
        @post_address.map_link = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('Map共有リンクを入力してください')
      end

      it 'map_linkはhttpもしくはhttpsで始まるURLでしか登録できないこと' do
        @post_address.map_link = 'www.google.com'
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('Map共有リンクはhttpもしくはhttpsで始まるURLで入力してください')
      end

      it 'postal_codeが空では登録できないこと' do
        @post_address.postal_code = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('郵便番号を入力してください')
      end

      it 'postal_codeは数値のみでしか登録できないこと' do
        @post_address.postal_code = '123-4567'
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('郵便番号は数値のみで入力してください')
      end

      it 'prefecture_codeが空では登録できないこと' do
        @post_address.prefecture_code = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('都道府県を入力してください')
      end

      it 'cityが空では登録できないこと' do
        @post_address.city = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('市区町村を入力してください')
      end

      it 'streetが空では登録できないこと' do
        @post_address.street = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('番地を入力してください')
      end

      it 'distanceが空では登録できないこと' do
        @post_address.distance = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('距離を入力してください')
      end

      it 'distanceが0km以下の場合は保存できないこと' do
        @post_address.distance = -5
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('距離は0より大きい値にしてください')
      end

      it 'distanceが全角文字では登録できないこと' do
        @post_address.distance = '５'
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('距離は数値で入力してください')
      end

      it 'distanceが英数字混合では登録できないこと' do
        @post_address.distance = '5a'
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('距離は数値で入力してください')
      end

      it 'distanceが半角英字では登録できないこと' do
        @post_address.distance = 'aa'
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('距離は数値で入力してください')
      end

      it 'courseが空では登録できないこと' do
        @post_address.course = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('山コース or 海コースを入力してください')
      end

      it 'slopeが空では登録できないこと' do
        @post_address.slope = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('坂の多さを入力してください')
      end

      it 'trafficが空では登録できないこと' do
        @post_address.traffic = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('交通量を入力してください')
      end

      it 'crowdが空では登録できないこと' do
        @post_address.crowd = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('人混みを入力してください')
      end

      it 'viewが空では登録できないこと' do
        @post_address.view = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('景色を入力してください')
      end

      it 'commentが空では登録できないこと' do
        @post_address.comment = ''
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('コメントを入力してください')
      end

      it 'userが紐付いていないと保存できないこと' do
        @post_address.user_id = nil
        @post_address.valid?
        expect(@post_address.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
