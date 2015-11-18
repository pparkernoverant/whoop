require 'spec_helper'

describe ReviewsController do
  describe 'POST create' do
    let!(:business_1) { Fabricate(:business) }

    context 'with authenticated user' do
      before { set_current_user }

      context 'with valid input' do
        before { post :create, business_id: business_1.id, review: Fabricate.attributes_for(:review).merge({ business_id: business_1.id }) }

        it 'creates the review' do
          expect(Review.count).to eq(1)
        end

        it 'displays a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the business show page' do
          expect(response).to redirect_to business_path(business_1)
        end
      end

      context 'with invalid input' do
        before { post :create, business_id: business_1.id, review: { business_id: business_1.id } }

        it 'does not create the review' do
          expect(Review.count).to eq(0)
        end

        it 'displays a flash error' do
          expect(flash[:error]).to be_present
        end

        it 'redirects to the business show page' do
          expect(response).to redirect_to business_path(business_1)
        end
      end
    end

    context 'with unauthenteicated user' do
      before { post :create, business_id: business_1.id, review: Fabricate.attributes_for(:review).merge({ business_id: business_1.id }) }

      it 'does not create the review' do
        expect(Review.count).to eq(0)
      end

      it 'displays a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'redirects to the root page' do
        expect(response).to redirect_to root_path
      end
    end
  end
end