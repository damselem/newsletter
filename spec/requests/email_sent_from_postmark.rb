require 'spec_helper'

describe 'Email sent from Postmark' do
  include PostmarkEmailFaker

  context 'given Postmark sends an email as JSON' do
    let(:header) do
      { 'RAW_POST_DATA' => fake_email }
    end

    context 'and the user does not exist' do
      it 'does not create a Post' do
        expect { post '/posts', {}, header }.to_not change{ Post.count }
      end

      it 'returns Forbidden status' do
        post '/posts', {}, header

        expect(response.forbidden?).to be_true
      end
    end

    context 'and the user exists' do
      before do
        create(:user, :email => 'daniel@email.com')
        Postmark::Mitt.any_instance.stub(:from_email).and_return('daniel@email.com')
      end

      it 'creates a Post' do
        expect { post '/posts', {}, header }.to change{ Post.count }
      end

      it 'returns OK status' do
        post '/posts', {}, header

        expect(response.ok?).to be_true
      end
    end
  end
end
