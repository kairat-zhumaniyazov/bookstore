require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
  describe 'GET #books_sold' do
    include_context 'books_and_stores'

    before { get :books_sold, params: { id: store_1.id }, format: :json }

    it { expect(response).to be_success }

    it 'should return right stores count' do
      expect(json['data'].count).to eq 2
    end

    it 'should include right stores' do
      expect(json['data'].first['id'].to_i).to eq book_2.id
      expect(json['data'].second['id'].to_i).to eq book_3.id
    end
  end
end
