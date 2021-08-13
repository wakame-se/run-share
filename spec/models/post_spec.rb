require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '新規投稿機能' do
    context '新規投稿ができる時' do
      it 'map_link、distance、textが存在すれば登録できること' do
        expect(@post).to be_valid
      end
    end

    context '新規投稿ができない時' do
      it 'map_linkが空では登録できないこと' do
        @post.map_link = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Map link can't be blank")
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

      it 'textが空では登録できないこと' do
        @post.text = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Text can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
