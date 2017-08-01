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
end
