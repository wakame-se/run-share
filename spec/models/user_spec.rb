require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー管理機能' do
    context 'ユーザー新規登録ができる時' do
      it 'すべての情報が存在すれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができない時' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailには@がないと登録できないこと' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
        @user.password = '12345a'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordが5文字以下では登録できないこと' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが半角英数字混合でなければ登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '12345a'
        @user.password_confirmation = '123456a'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できないこと' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角文字で入力してください')
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できないこと' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角文字で入力してください')
      end

      it 'last_name_readingが空では登録できないこと' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字カナを入力してください")
      end

      it 'first_name_readingが空では登録できないこと' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナを入力してください")
      end

      it 'last_name_readingは全角（カタカナ）でなければ登録できないこと' do
        @user.last_name_reading = 'bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナは全角カナ文字で入力してください')
      end

      it 'first_name_readingは全角（カタカナ）でなければ登録できないこと' do
        @user.first_name_reading = 'bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは全角カナ文字で入力してください')
      end

      it 'birthdayが空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
