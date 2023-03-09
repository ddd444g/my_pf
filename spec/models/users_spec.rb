require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "nameに対するバリデーションが効いているか" do
    it "nameがnilなら登録できないこと" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "nameが空なら登録できないこと" do
      user = User.new(name: " ")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  describe "emailアドレスに対するバリデーションが効いているか" do
    it "emailアドレスがなければ登録できないこと" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "emailアドレスが正規表現でなければ登録できないこと" do
      user = User.new(email: "aaa")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it "同じemailアドレスがあると登録できないこと" do
      other_user = User.new(email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("has already been taken")
    end
  end
end
