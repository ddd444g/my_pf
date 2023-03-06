require 'rails_helper'

RSpec.describe "Users_system", type: :system do
  let!(:user) { create(:user) }
  before do
    visit users_path
  end

  describe 'userの情報が表示されてるか' do
    it "nameが表示されていること" do
      expect(page).not_to have_content user.name
    end

    it "idが表示されていること" do
      expect(page).not_to have_content user.id
    end
  end

  describe 'user詳細画面へ遷移確認' do
    it "参照をクリックで詳細ページへ行けること" do
      click_link "参照"
      expect(current_path).to eq user_path(user.id)
    end
  end
end
