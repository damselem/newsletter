require 'spec_helper'

describe User do
  include OauthFaker

  it { should respond_to(:uid) }
  it { should respond_to(:provider) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }

  it { should allow_mass_assignment_of(:provider) }
  it { should allow_mass_assignment_of(:uid) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:email) }

  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }

  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }

  it { should have_many(:posts) }


  describe '.from_omniauth' do

    context 'given some OAuth parameters received from a provider' do
      let(:oauth_params) { oauth_fake_params }

      context 'given a user exists for those parameters' do
        before do
          attributes = {
            :provider => oauth_params[:provider],
            :uid      => oauth_params[:uid]
          }

          @user = create(:user, attributes)
        end

        it 'returns the existent user' do
          user = User.from_omniauth(oauth_params)

          expect(user).to eq(@user)
        end
      end

      context 'given no user exists for those parameters' do
        it 'returns nil' do
          user = User.from_omniauth(oauth_params)

          expect(user).to be_nil
        end
      end
    end
  end

  describe '.create_from_omniauth' do
    context 'given some OAuth parameters sent from a provider' do
      let(:oauth_params) { oauth_fake_params }

      context 'given the token is valid' do
        before do
          OmniAuth::Auth.any_instance.stub(:is_token_valid?).and_return(true)
        end

        context 'given the email is from klarna' do
          before do
            OmniAuth::Auth.any_instance.stub(:is_klarna_account?).and_return(true)
          end

          let(:user) { User.create_from_omniauth(oauth_params) }

          it 'creates a new User' do
            expect(user).to be_a(User)
          end

          it 'sets the provider to google_oauth2' do
            expect(user.provider).to eq(oauth_params[:provider])
          end

          it 'sets the uid to 123456789' do
            expect(user.uid).to eq(oauth_params[:uid])
          end

          it 'sets the first name' do
            expect(user.first_name).to eq(oauth_params[:info][:first_name])
          end

          it 'sets the last name' do
            expect(user.last_name).to eq(oauth_params[:info][:last_name])
          end

          it 'sets the email' do
            expect(user.email).to eq(oauth_params[:info][:email])
          end
        end
      end

      context 'given the token is invalid' do
        before do
          OmniAuth::Auth.any_instance.stub(:is_token_valid?).and_return(false)
        end

        it 'does not create a new User' do
          user = User.create_from_omniauth(oauth_params)

          expect(user).to be_nil
        end
      end

      context 'given the emails is not from klarna' do
        before do
          OmniAuth::Auth.any_instance.stub(:is_klarna_account?).and_return(false)
        end

        it 'does not create a new User' do
          user = User.create_from_omniauth(oauth_params)

          expect(user).to be_nil
        end
      end

    end
  end

  describe '#full_name' do
    context 'given a user with only first name' do
      let(:user) { create(:user, :first_name => 'Daniel', :last_name => '') }

      it 'returns ' do
        expect(user.full_name).to eq('Daniel')
      end
    end

    context 'given a user with last name only' do
      let(:user) { create(:user, :first_name => '', :last_name => 'Salmeron Amselem') }

      it 'returns ' do
        expect(user.full_name).to eq('Salmeron Amselem')
      end
    end

    context 'given a user with first and last name' do
      let(:user) { create(:user, :first_name => 'Daniel', :last_name => 'Salmeron Amselem') }

      it 'returns ' do
        expect(user.full_name).to eq('Daniel Salmeron Amselem')
      end
    end

    context 'given a user with no first or last name' do
      let(:user) { create(:user, :first_name => '', :last_name => '') }

      it 'returns the user email' do
        expect(user.full_name).to eq(user.email)
      end
    end
  end

  describe '#gravatar_image_url' do
    context 'given a user with an email' do
      let(:user) { create(:user) }

      it 'returns a gravatar-like url' do
        expect(user.gravatar_image_url).to match(/gravatar.com/)
      end
    end
  end

end
