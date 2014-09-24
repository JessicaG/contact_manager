require 'rails_helper'

describe EmailAddress do
  let(:email_address) {EmailAddress.new(address: 'sample@example.com', person_id: 1)}

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid if empty' do
    email_address.address = nil
    expect(email_address).to_not be_valid
  end

  it 'is invalid without person id' do
    email_address.person_id = nil
    expect(email_address).to_not be_valid
  end
end
