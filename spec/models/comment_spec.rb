require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント機能' do
    context 'コメントができる時' do
      it 'コメントがあれば登録できること' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントができない時' do
      it 'commentが空では登録できないこと' do
        @comment.comment = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end

      it 'postが紐付いていないと保存できないこと' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Postを入力してください')
      end
    end
  end
end
