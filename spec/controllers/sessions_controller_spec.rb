require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    context 'with authenticated user' do
      before do
        set_current_user
        get :new
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with unauthenticated user' do
      before { get :new }

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST create' do
    context 'with authenticated user' do
      before do
        set_current_user
        post :create
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with unauthenticated user' do
      let!(:user_1) { Fabricate(:user) }

      context 'with valid credentials' do
        before { post :create, session: { username: user_1.username, password: user_1.password } }

        it 'puts the user into the session' do
          expect(session[:user_id]).to eq(user_1.id)
        end

        it 'displays a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the root page' do
          expect(response).to redirect_to root_path
        end
      end

      context 'with invalid credentials' do
        before { post :create, session: { username: user_1.username, password: user_1.password + '1' } }

        it 'does not put the user into the session' do
          expect(session[:user_id]).to eq(nil)
        end

        it 'displays a flash error' do
          expect(flash[:error]).to be_present
        end

        it 'redirects to the login page' do
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe 'GET destroy' do
    context 'with authenticated user' do
      let!(:user_1) { Fabricate(:user) }
      before do
        session[:user_id] = user_1.id
        get :destroy
      end

      it 'clears the session' do
        expect(session[:user_id]).to eq(nil)
      end

      it 'displays a flash notice' do
        expect(flash[:notice]).to be_present
      end
    end

    it 'redirects to the root path' do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end