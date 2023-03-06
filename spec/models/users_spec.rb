require 'rails_helper'

RSpec.describe User, type: :model do

  describe "バリデーションが効いているか" do
    it "nameがなければ登録でないこと" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
end
