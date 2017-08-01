require 'rails_helper'

RSpec.describe Api::V1::PublishersController, type: :controller do
  describe 'GET #in_stores' do
    include_context 'books_and_stores'

    before { get :in_stores, params: { id: publisher.id }, format: :json }

    it { expect(response).to be_success }

    it 'should return right stores count' do
      expect(json['data'].count).to eq 2
    end

    it 'should include right stores' do
      expect(json['data'].first['id'].to_i).to eq store_1.id
      expect(json['data'].second['id'].to_i).to eq store_2.id
    end
  end
end
