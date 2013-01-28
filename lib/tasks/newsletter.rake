namespace :newsletter do

  desc 'Send Newsletter'
  task :send => :environment do
    if DateTime.now.wday == 4
      posts = Post.from_current_week

      NewsletterMailer.weekly_newsletter(posts).deliver if posts.present?
      Rails.logger.info "rake newsletter:send => #{posts.count} posts sent"
    end
  end

end
