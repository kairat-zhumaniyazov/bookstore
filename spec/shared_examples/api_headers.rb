shared_examples_for 'API :get status success' do
  it 'should returns status 200' do
    expect(response).to be_success
  end
end

shared_examples_for 'API status not_found' do
  it 'should returns status 404' do
    subject
    expect(response).to be_not_found
  end
end

shared_examples_for 'API :post status created' do
  it 'should returns status 201' do
    subject
    expect(response).to be_created
  end
end

shared_examples_for 'API status unprocessable_entity' do
  it 'should returns status 422' do
    subject
    expect(response.status).to eq 422
  end
end
