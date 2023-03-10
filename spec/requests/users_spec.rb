require 'rails_helper'

RSpec.describe "Users_request", type: :request do
  let!(:user) { create(:user) }

  describe 'GET #index' do
    before do
      get users_url
    end

    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end

    it 'ユーザー名が取得されていること' do
      expect(response.body).to include "test"
    end

    it 'emailアドレスが取得されていること' do
      expect(response.body).to include user.email
    end
  end

  describe 'GET #show' do
    before do
      get user_url user.id
    end

    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end

    it 'ユーザ名が取得されていること' do
      expect(response.body).to include user.name
    end

    it 'emailアドレスが取得されていること' do
      expect(response.body).to include user.email
    end
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_user_url
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    before do
      get edit_user_url user.id
    end

    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end

    it 'ユーザー名が取得されていること' do
      expect(response.body).to include user.name
    end

    it 'emailアドレスが取得されていること' do
      expect(response.body).to include user.email
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'ユーザーが登録されること' do
        expect do
          post users_url, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'リダイレクトすること' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response).to redirect_to users_url
      end
    end

    context 'パラメータが不正な場合' do
      it '新規登録画面のままでいること' do
        post users_url, params: { user: { name: nil } }
        expect(response.status).to eq 422
      end

      it 'エラーメッセージが取得されていること' do
        post users_url, params: { user: { name: nil } }
        expect(response.body).to include "を入力してください"
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post users_url, params: { user: { name: nil } }
        end.to_not change(User, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put user_url user, params: { user: attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'ユーザー名が更新されること' do
        expect do
          put user_url user, params: { user: { name: "test2" } }
        end.to change { User.find(user.id).name }.from('test').to('test2')
      end

      it 'リダイレクトすること' do
        put user_url user, params: { user: attributes_for(:user) }
        expect(response).to redirect_to users_url
      end
    end
  end

  context 'パラメータが不正な場合' do
    it '画面が移動しないこと' do
      put user_url user, params: { user: { name: nil } }
      expect(response.status).to eq 422
    end

    it 'エラーメッセージが取得されるてこと' do
      put user_url user, params: { user: { name: nil } }
      expect(response.body).to include "を入力してください"
    end

    it 'ユーザー名が変更されないこと' do
      expect do
        put user_url user, params: { user: { name: nil } }
      end.to_not change(User.find(user.id), :name)
    end
  end

  describe 'DELETE #destroy' do
    it 'リクエストが成功すること' do
      delete user_url user
      expect(response.status).to eq 302
    end

    it 'ユーザーが削除されること' do
      expect do
        delete user_url user
      end.to change(User, :count).by(-1)
    end

    it 'ユーザー一覧にリダイレクトすること' do
      delete user_url user.id
      expect(response).to redirect_to users_url
    end
  end
end
