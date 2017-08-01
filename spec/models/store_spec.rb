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
    context 'with available books' do
      let(:book) { create :book }
      let(:another_book ) { create :book }

      let(:store_1) { create :store }
      let(:store_2) { create :store }
      let(:store_3) { create :store }

      subject { Store.with_available_books }

      before do
        Stock.create store: store_1, book: book, amount: 0
        Stock.create store: store_2, book: book, amount: 1
        Stock.create store: store_3, book: book, amount: 0

        Stock.create store: store_1, book: another_book, amount: 1
        Stock.create store: store_2, book: another_book, amount: 1
        Stock.create store: store_3, book: another_book, amount: 0
      end

      it { expect(subject.count).to eq 2 }
      it { expect(subject).to include(store_1) }
      it { expect(subject).to include(store_2) }
      it { expect(subject).to_not include(store_3) }
    end
  end
end
