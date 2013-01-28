namespace :newsletter do

  desc 'Send Newsletter'
  task :send => :environment do
    if DateTime.now.wday == 4
      posts = Post.from_current_week

      NewsletterMailer.weekly_newsletter(posts).deliver if posts
      Rails.logger.info 'Newsletter sent'
    end
  end

end
