require 'spec_helper'

describe BusinessesController do
  describe 'GET index' do
    it 'sets @businesses' do
      business_1 = Fabricate(:business)
      business_2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([business_1, business_2])
    end
  end

  describe 'POST create' do
    context 'with authenticated user' do
      before { set_current_user }

      context 'with valid input' do
        before { post :create, business: Fabricate.attributes_for(:business) }

        it 'creates the business' do
          expect(Business.count).to eq(1)
        end

        it 'redirects to the business index page' do
          expect(response).to redirect_to businesses_path
        end

        it 'displays a flash notice' do
          expect(flash[:notice]).to be_present
        end
      end

      context 'with invalid input' do
        let!(:business_1) { Fabricate(:business) }
        before { post :create, business: Fabricate.attributes_for(:business).merge(name: business_1.name) }

        it 'does not create the business' do
          expect(Business.count).to eq(1)
        end

        it 'renders the :new template' do
          expect(response).to render_template :new
        end

        it 'displays a flash error' do
          expect(flash[:error]).to be_present
        end
      end
    end

    context 'with unauthenticated user' do
      before { post :create, business: Fabricate.attributes_for(:business) }

      it 'does not create the business' do
        expect(Business.count).to eq(0)
      end

      it 'redirects to the root page' do
        expect(response).to redirect_to root_path
      end

      it 'displays a flash error' do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET new' do
    context 'with authenticated user' do
      before do
        set_current_user
        get :new
      end

      it 'sets @business' do
        expect(assigns(:business)).to be_instance_of(Business)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    context 'with unauthenticated user' do
      before { get :new }

      it 'redirects to the root page' do
        expect(response).to redirect_to root_path
      end

      it 'displays a flash error' do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET show' do
    it 'sets the @business'
    # Nothing to test here
  end

end