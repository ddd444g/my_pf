require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "User" do
    it "name,email,passwordがあれば有効な状態であること" do
      expect(user).to be_valid
    end
  end

  describe "Userモデルのバリデーションが有効であるか" do
    context "nameに対するバリデーション" do
      it "nameがnilなら登録できないこと" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "nameが空なら登録できないこと" do
        user = build(:user, name: " ")
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end
    end

    context "emailに対するバリデーション" do
      it "emailアドレスがなければ登録できないこと" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "emailアドレスが空なら登録できないこと" do
        user = build(:user, email: " ")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "emailアドレスが正規表現でなければ登録できないこと" do
        user = build(:user, email: "test")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end

      it ".がなければ登録できないこと" do
        user = build(:user, email: "test@testcom")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end

      it "@がなければ登録できないこと" do
        user = build(:user, email: "test_test.com")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end

      it "同じemailアドレスがあると登録できないこと" do
        other_user = build(:user, email: user.email)
        other_user.valid?
        expect(other_user.errors[:email]).to include("はすでに存在します")
      end
    end

    context "passwordに対するバリデーション" do
      it "passwordがなければ登録できないこと" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "passwordが空なら登録できないこと" do
        user = build(:user, password: " ")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "passwordが6文字以上なら有効であること" do
        user = build(:user, password: "123456", password_confirmation: "123456")
        expect(user).to be_valid
      end

      it "passwordが5文字以下なら登録できないこと" do
        user = build(:user, password: "12345", password_confirmation: "12345")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "passwordが確認用パスワードと一致しないと登録できないこと" do
        user = build(:user, password: "123456", password_confirmation: "654321")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end
