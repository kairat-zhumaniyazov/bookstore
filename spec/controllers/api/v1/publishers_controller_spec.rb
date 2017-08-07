require 'rails_helper'

RSpec.describe Api::V1::PublishersController, type: :controller do
  describe 'GET #show' do
    context 'with valid ID' do
      before { get :show, params: { id: publisher.id }, format: :json }

      let!(:publisher) { create :publisher}

      include_examples 'API :get status success'

      it { expect(json['id'].to_i).to eq publisher.id }
      it { expect(json['attributes']['name']).to eq publisher.name }
    end

    context 'with invalid ID' do
      before { get :show, params: { id: 123123123 }, format: :json }

      include_examples 'API status not_found'
    end
  end

  describe 'GET #index' do
    let!(:publishers) { create_list :publisher, 5 }

    before { get :index, format: :json }

    include_examples 'API :get status success'

    it { expect(json.count).to eq publishers.count }
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'with valid params' do
      let(:params) { { publisher: { name: 'Publisher name' }, format: :json } }

      include_examples 'API :post status created'

      it { expect{ subject }.to change(Publisher, :count).by(1) }

      it 'should return json' do
        subject
        expect(json['attributes']['name']).to eq 'Publisher name'
      end
    end

    context 'with invalid params' do
      let(:params) { { publisher: { name: '' }, format: :json } }

      include_examples 'API status unprocessable_entity'

      it { expect{ subject }.to_not change(Publisher, :count) }
    end
  end

  describe 'POST #update' do
    let!(:publisher) { create :publisher }

    subject { put :update, params: params }

    context 'with valid params' do
      let(:params) { { id: publisher.id, publisher: { name: 'Updated name' }, format: :json } }

      it { expect{ subject }.to change{ publisher.reload.name }.to('Updated name') }

      it 'should return json' do
        subject
        expect(json['attributes']['name']).to eq 'Updated name'
      end
    end

    context 'with invalid params' do
      let(:params) { { id: publisher.id, publisher: { name: '' }, format: :json } }

      it { expect{ subject }.to_not change{ publisher.reload.name } }
    end
  end

  describe 'DELETE #destroy' do
    let!(:publisher) { create :publisher }

    subject { delete :destroy, params: params }

    context 'with valid ID' do
      let(:params) { { id: publisher.id, format: :json } }

      it { expect{ subject }.to change(Publisher, :count).by(-1) }
    end

    context 'with invalid ID' do
      let(:params) { { id: 123123123, format: :json } }

      include_examples 'API status not_found'
      it { expect{ subject }.to_not change(Publisher, :count) }
    end
  end
end
