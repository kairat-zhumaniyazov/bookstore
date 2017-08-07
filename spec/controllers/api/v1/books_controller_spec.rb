require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET #show' do
    context 'with valid ID' do
      before { get :show, params: { id: book.id }, format: :json }

      let!(:book) { create :book }

      include_examples 'API :get status success'

      it { expect(json['id'].to_i).to eq book.id }
      it { expect(json['attributes']['title']).to eq book.title }
    end

    context 'with invalid ID' do
      before { get :show, params: { id: 123123123 }, format: :json }

      include_examples 'API status not_found'
    end
  end

  describe 'GET #index' do
    let!(:books) { create_list :book, 5 }

    before { get :index, format: :json }

    include_examples 'API :get status success'

    it { expect(json.count).to eq books.count }
  end

  describe 'POST #create' do
    let!(:publisher) { create :publisher }

    subject { post :create, params: params }

    context 'with valid params' do
      let(:params) { { book: { title: 'Book title' }, publisher_id: publisher.id, format: :json } }

      include_examples 'API :post status created'

      it { expect{ subject }.to change(publisher.books, :count).by(1) }
    end

    context 'with invalid params' do
      let(:params) { { book: { title: '' }, publisher_id: publisher.id, format: :json } }

      include_examples 'API status unprocessable_entity'

      it { expect{ subject }.to_not change(Book, :count) }

      context 'when invalid publisher id' do
        let(:params) { { book: { title: 'Book title' }, format: :json } }

        before { subject }

        include_examples 'API status not_found'

        it { expect{ subject }.to_not change(Book, :count) }
      end
    end
  end

  describe 'POST #update' do
    let!(:book) { create :book }

    subject { put :update, params: params }

    context 'with valid params' do
      let(:params) { { id: book.id, book: { title: 'Updated title' }, format: :json } }

      it { expect{ subject }.to change{ book.reload.title }.to('Updated title') }
    end

    context 'with invalid params' do
      let(:params) { { id: book.id, book: { title: '' }, format: :json } }

      it { expect{ subject }.to_not change{ book.reload.title } }
    end
  end

  describe 'DELETE #destroy' do
    let!(:book) { create :book }

    subject { delete :destroy, params: params }

    context 'with valid ID' do
      let(:params) { { id: book.id, format: :json } }

      it { expect{ subject }.to change(Book, :count).by(-1) }
    end

    context 'with invalid ID' do
      let(:params) { { id: 123123123, format: :json } }

      include_examples 'API status not_found'
      it { expect{ subject }.to_not change(Book, :count) }
    end
  end
end
