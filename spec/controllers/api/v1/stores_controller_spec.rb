require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
  describe 'GET #publisher_books' do
    include_context 'books_and_stores'

    context 'with valid params' do
      before { get :publisher_books, params: { publisher_id: publisher.id }, format: :json }

      it { expect(response).to be_success }

      it 'should return right stores count' do
        expect(json.count).to eq 2
      end

      it 'should include right stores' do
        expect(json.first['id'].to_i).to eq store_1.id
        expect(json.second['id'].to_i).to eq store_2.id
      end
    end

    context 'with invalid params' do
      before { get :publisher_books, params: { publisher_id: 123123123123 }, format: :json }

      it { expect(response.status).to eq 404 }
    end
  end

  describe 'GET #books_sold' do
    include_context 'books_and_stores'

    before { get :books_sold, params: { id: store_1.id }, format: :json }

    it { expect(response).to be_success }

    it 'should return right stores count' do
      expect(json.count).to eq 2
    end

    it 'should include right stores' do
      expect(json.first['id'].to_i).to eq book_2.id
      expect(json.second['id'].to_i).to eq book_3.id
    end
  end

  describe 'GET #show' do
    context 'with valid ID' do
      before { get :show, params: { id: store.id }, format: :json }

      let!(:store) { create :store }

      include_examples 'API :get status success'

      it { expect(json['id'].to_i).to eq store.id }
      it { expect(json['attributes']['name']).to eq store.name }
    end

    context 'with invalid ID' do
      before { get :show, params: { id: 123123123 }, format: :json }

      include_examples 'API status not_found'
    end
  end

  describe 'GET #index' do
    let!(:stores) { create_list :store, 5 }

    before { get :index, format: :json }

    include_examples 'API :get status success'

    it { expect(json.count).to eq stores.count }
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'with valid params' do
      let(:params) { { store: { name: 'Store name' }, format: :json } }

      include_examples 'API :post status created'

      it { expect{ subject }.to change(Store, :count).by(1) }

      it 'should return json' do
        subject
        expect(json['attributes']['name']).to eq 'Store name'
      end
    end

    context 'with invalid params' do
      let(:params) { { store: { name: '' }, format: :json } }

      include_examples 'API status unprocessable_entity'

      it { expect{ subject }.to_not change(Store, :count) }
    end
  end

  describe 'POST #update' do
    subject { put :update, params: params }

    let(:store) { create :store }

    context 'with valid params' do
      let(:params) { { id: store.id, store: { name: 'Updated name' }, format: :json } }

      it { expect{ subject }.to change{ store.reload.name }.to('Updated name') }

      it 'should return json' do
        subject
        expect(json['attributes']['name']).to eq 'Updated name'
      end
    end

    context 'with invalid params' do
      let(:params) { { id: store.id, store: { name: '' }, format: :json } }

      it { expect{ subject }.to_not change{ store.reload.name } }
    end
  end

  describe 'DELETE #destroy' do
    let!(:store) { create :store }

    subject { delete :destroy, params: params }

    context 'with valid ID' do
      let(:params) { { id: store.id, format: :json } }

      it { expect{ subject }.to change(Store, :count).by(-1) }
    end

    context 'with invalid ID' do
      let(:params) { { id: 123123123123, format: :json } }

      include_examples 'API status not_found'

      it { expect{ subject }.to_not change(Store, :count) }
    end
  end
end
