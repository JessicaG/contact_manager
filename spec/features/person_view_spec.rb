require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: "555-1234")
    person.phone_numbers.create(number: "555-5678")
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add a new phone number' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
  end

  it 'adds a new phone number' do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '555-8888')
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-8888')
  end

  it 'edits a phone number' do
    phone = person.phone_numbers.first
    old_number = phone.number

    first(:link, 'edit').click
    page.fill_in('Number', with: '555-9191')
    page.click_button('Update Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-9191')
    expect(page).to_not have_content(old_number)
  end

  it 'has links to delete phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('delete', href: phone_number_path(phone))
    end
  end

  it 'deletes a phone number' do
    bad_number = person.phone_numbers.first
    good_number  = person.phone_numbers.last

    first(:link, 'delete').click
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content(good_number.number)
    expect(page).to_not have_content(bad_number.number)
  end

  describe 'has email addresses that' do
    let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

    before(:each) do
      person.email_addresses.create(address: "email@email.com")
      person.email_addresses.create(address: "admin@admin.com")
      visit person_path(person)
    end

    it 'has a list of email addresses' do
      expect(page).to have_selector('li', text: person.email_addresses.first.email)
    end

    it 'has an add email address link' do
      expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
    end

    it 'creates a new email address' do
      pending
      page.click_link('Add email address')
      fill_in 'Email', with: 'new@email.com'
      page.click_on('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('new@email.com')
    end

    it 'edits email addresses' do
      pending
      email = person.email_addresses.first
      old_email = email.email

      first(:link, 'edit').click
      page.fill_in('Email', with: 'new@email.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('new@email.com')
      expect(page).to_not have_content(old_email)
    end

    it 'deletes email addresses' do
      pending
      bad_email = person.email_addresses.first
      good_email = person.email_addresses.last

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content(good_email.email)
      expect(page).to_not have_content(bad_email.email)
    end
  end

end
