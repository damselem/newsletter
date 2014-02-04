require 'digest/md5'

class User < ActiveRecord::Base
  has_many :posts
  has_many :active_posts, class_name: 'Post', conditions: {archived: false}

  validates :uid,   :uniqueness => { :scope => :provider }
  validates :email, :uniqueness => true

  validates :uid,      :presence => true
  validates :provider, :presence => true

  attr_accessible :provider, :uid, :first_name, :last_name, :email

  def self.from_omniauth(oauth_params)
    where(:provider => oauth_params[:provider]).
    where(:uid => oauth_params[:uid]).
    first
  end

  def self.create_from_omniauth(oauth_params)
    auth = OmniAuth::Auth.new(oauth_params)

    if auth.is_token_valid? && auth.is_klarna_account?
      User.create({
        :first_name => oauth_params[:info][:first_name],
        :last_name  => oauth_params[:info][:last_name],
        :email      => oauth_params[:info][:email],
        :provider   => oauth_params[:provider],
        :uid        => oauth_params[:uid]
      })
    end
  end

  def full_name
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}".strip
    else
      email
    end
  end

  def gravatar_image_url
    hash = Digest::MD5.hexdigest(email)

    "http://www.gravatar.com/avatar/#{hash}"
  end
end
