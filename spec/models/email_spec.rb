require 'spec_helper'

describe Email do
  include PostmarkEmailFaker

  context 'given an email from postmark' do
    let(:email) { Email.new(fake_email) }

    describe '#user' do

      context 'given the user already exists' do
        before do
          email_address = email.instance_variable_get(:@postmark).from_email
          @user = create(:user, :email => email_address)
        end

        it 'returns the existent user' do
          expect(email.user).to eq(@user)
        end

        it 'does not create a new user in the database' do
          expect { email.user }.not_to change { User.count }
        end
      end

      context 'given the user does not exist' do
        it 'returns nil' do
          expect(email.user).to be_nil
        end
      end
    end

    describe '#body' do

      context 'given the body is Markdown' do
        let(:markdown_email) do
          Email.new(fake_markdown_email)
        end

        it 'returns rendered Markdown as HTML' do
          html = '<a href="https://github.com/fbzhong/sublime-jslint">SublimeText2</a>'

          expect(markdown_email.body).to include(html)
        end

      end

      context 'given the body is not Markdown' do

        it 'returns the same text' do
          expect(email.body).to include('<p>A Lint is a tool')
        end

      end
    end

  end
end
