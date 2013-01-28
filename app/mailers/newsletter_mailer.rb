class NewsletterMailer < ActionMailer::Base
  default :css => :email, :from => ENV['NEWSLETTER_FROM_EMAIL']

  def weekly_newsletter(posts)
    @posts = posts
    mail(:to => User.all.map(&:email), :subject => 'Klarna TLV Weekly Newsletter')
  end
end
