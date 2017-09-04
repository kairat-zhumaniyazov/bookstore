require 'rails_helper'

RSpec.describe Api::V1::PublisherBooksController, type: :controller do
  include_context 'books_and_stores'

  describe 'GET #index' do
    before { get :index, params: { publisher_id: publisher.id }, format: :json }

    include_examples 'API :get status success'

    it { expect(json.count).to eq 2 }
  end

  describe 'GET #show' do
    before { get :show, params: params, format: :json }

    context 'with valid prams' do
      let(:params) { { publisher_id: publisher.id, id: book_1.id } }

      include_examples 'API :get status success'

      it { expect(json['id'].to_i).to eq book_1.id }
    end

    context 'with invalid params' do
      context 'when invalid book id' do
        let(:params) { { publisher_id: publisher.id, id: 123123123 } }

        include_examples 'API :get status success'

        it { expect(response.body).to eq 'null' }
      end

      context 'when invalid publisher id' do
        let(:params) { { publisher_id: 12312312, id: book_1.id } }

        include_examples 'API status not_found'
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'with valid params' do
      let(:params) { { book: { title: 'Book title' }, publisher_id: publisher.id, format: :json } }

      include_examples 'API :post status created'

      it { expect{ subject }.to change(publisher.books, :count).by(1) }

      it 'should return json' do
        subject
        expect(json['attributes']['title']).to eq 'Book title'
      end
    end

    context 'with invalid params' do
      let(:params) { { book: { title: '' }, publisher_id: publisher.id, format: :json } }

      include_examples 'API status unprocessable_entity'

      it { expect{ subject }.to_not change(Book, :count) }

      context 'when invalid publisher id' do
        let(:params) { { publisher_id: 123123123, book: { title: 'Book title' }, format: :json } }

        before { subject }

        include_examples 'API status not_found'

        it { expect{ subject }.to_not change(Book, :count) }
      end
    end
  end
end
