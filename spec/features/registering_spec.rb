require 'rails_helper'

describe 'Registration management', type: :feature do
  let(:user) { build(:user) }

  before :each do
    visit unauthenticated_root_path
    click_link 'Sign up'
    
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_button 'Sign up'      
  end

  it 'shows a message about a confirmation email' do
    expect(page).to have_content('A message with a confirmation link')
  end

  describe 'Confirmation email' do
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    subject { open_email(user.email) }

    it { is_expected.to deliver_to(user.email)}
    it { is_expected.to have_body_text('You have successfully signed up') }
  end

  context 'when clicking confirmation link in email' do
    before :each do
      open_email(user.email)
      current_email.click_link 'Confirm my account'
    end

    it 'shows confirmation page' do
      expect(page).to have_content('Your email address has been successfully confirmed')
    end

    it 'confirms user' do
      confirmed_user = User.find_for_authentication(email: user.email)
      expect(confirmed_user).to be_confirmed
    end
  end
end