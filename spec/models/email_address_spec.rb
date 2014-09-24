require 'rails_helper'

describe EmailAddress do
  let(:email_address) {EmailAddress.new(email: 'sample@example.com', contact_id: 1, contact_type: 'Person')}

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid if empty' do
    pending
    email_address.email = nil
    expect(email_address).to_not be_valid
  end

  it 'is invalid without person id' do
    pending
    email_address.contact_id = nil
    expect(email_address).to_not be_valid
  end
end
