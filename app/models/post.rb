class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :presence => true
  validates :body,  :presence => true
  validates :user,  :presence => true

  def self.new_from_postmark(postmark)
    email = Email.new(postmark)

    new do |post|
      post.title = email.subject
      post.body  = email.body
      post.user  = email.user
    end
  end

  def self.list(page)
    includes(:user).
    order('posts.created_at DESC').
    page(page).per(10).
    non_archived
  end

  def self.show(id)
    includes(:user).
    where(:id => id).
    non_archived.
    first
  end

  def archive
    update_attribute(:archived, true)
  end

  private

  def self.non_archived
    where(:archived => false)
  end
end
