# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of :name }

  it { should have_many(:stocks).dependent(:destroy) }
  it { should have_many(:books).through(:stocks) }

  describe 'scopes' do
    include_context 'books_and_stores'

    context 'with available books' do
      subject { Store.with_available_books_for_publisher(publisher) }

      it { expect(subject.count).to eq 2 }
      it { expect(subject).to include(store_1) }
      it { expect(subject).to include(store_2) }
      it { expect(subject).to_not include(store_3) }
    end
  end

  describe '#add_stock' do
    let!(:store) { create :store }
    let!(:book) { create :book }

    subject { store.add_stock(params) }

    context 'with valid params' do
      let(:params) { { book_id: book.id, amount: 10 } }

      it { expect{ subject }.to change{ store.books.count }.by(1) }
    end

    context 'with invalid params' do
      let(:params) { { book_id: 12312312 } }

      it { expect{ subject }.to_not change{ store.books.count } }
    end
  end
end
