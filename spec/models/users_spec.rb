require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "nameに対するバリデーションが効いているか" do
    it "nameがnilなら登録できないこと" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "nameが空なら登録できないこと" do
      user = User.new(name: " ")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
  end

  describe "emailアドレスに対するバリデーションが効いているか" do
    it "emailアドレスがなければ登録できないこと" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailアドレスが正規表現でなければ登録できないこと" do
      user = User.new(email: "aaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "同じemailアドレスがあると登録できないこと" do
      other_user = User.new(email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("はすでに存在します")
    end
  end
end
