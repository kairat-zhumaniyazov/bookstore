# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  publisher_id :integer
#

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }

  it { should belong_to :publisher }
  it { should have_many(:stocks).dependent(:destroy) }
  it { should have_many(:stores).through(:stocks) }

  describe 'scopes' do
    include_context 'books_and_stores'

    context 'sold books' do
      subject { store_1.books.sold }

      it { expect(subject.count).to eq 2 }
      it { expect(subject).to_not include(book_1) }
      it { expect(subject).to include(book_2) }
      it { expect(subject).to include(book_3) }
    end
  end
end
