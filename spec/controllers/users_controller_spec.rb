require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'creates a flash notice' do
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid input' do
      before { post :create, user: { username: 'test_username', email: 'test_email'} }

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'creates a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET edit' do
    context 'when @user is current user' do
      before { set_current_user }

      it 'renders the :edit template' do
        get :edit, id: current_user.id
        expect(response).to render_template :edit
      end
    end

    context 'when @user is not current user' do
      let!(:user_1) { Fabricate(:user) }
      let!(:user_2) { Fabricate(:user) }
      before do
        set_current_user(user_1)
        get :edit, id: user_2.id
      end

      it 'creates a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET show' do
    # Nothing to test here
  end

  describe 'PATCH update' do
    let!(:user_1) { Fabricate(:user) }
    let!(:user_2) { Fabricate(:user) }

    context 'when @user is current user' do
      before { set_current_user(user_1) }

      context 'with valid input' do
        let!(:expected_email) { user_1.email + '1' }
        before { patch :update, id: user_1.id, user: {email: expected_email} }

        it 'updates the user\'s profile' do
          expect(user_1.reload.email).to eq(expected_email)
        end

        it 'creates a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the show page' do
          expect(response).to redirect_to user_path(user_1)
        end
      end

      context 'with invalid input' do
        before { patch :update, id: user_1.id, user: { username: user_2.username } }

        it 'does not update the user\'s profile' do
          expect(user_1.attributes).to eq(user_1.reload.attributes)
        end

        it 'creates a flash error' do
          expect(flash[:error]).to be_present
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'when @user is not current user' do
      before { patch :update, id: user_2.id, user: { username: user_2.username + '1' } }

      it 'does not update the user\'s profile' do
        expect(user_2.attributes).to eq(user_2.reload.attributes)
      end

      it 'creates a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PUT update' do
    let!(:user_1) { Fabricate(:user) }
    let!(:user_2) { Fabricate(:user) }

    context 'when @user is current user' do
      before { set_current_user(user_1) }

      context 'with valid input' do
        let!(:expected_email) { user_1.email + '1' }
        before { patch :update, id: user_1.id, user: {email: expected_email} }

        it 'updates the user\'s profile' do
          expect(user_1.reload.email).to eq(expected_email)
        end

        it 'creates a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the show page' do
          expect(response).to redirect_to user_path(user_1)
        end
      end

      context 'with invalid input' do
        before { patch :update, id: user_1.id, user: { username: user_2.username } }

        it 'does not update the user\'s profile' do
          expect(user_1.attributes).to eq(user_1.reload.attributes)
        end

        it 'creates a flash error' do
          expect(flash[:error]).to be_present
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'when @user is not current user' do
      before { patch :update, id: user_2.id, user: { username: user_2.username + '1' } }

      it 'does not update the user\'s profile' do
        expect(user_2.attributes).to eq(user_2.reload.attributes)
      end

      it 'creates a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

end