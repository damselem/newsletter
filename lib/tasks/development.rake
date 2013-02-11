namespace :development do
  desc 'Add some fake emails'
  task :create_fake_email => :environment do
    file_name    = 'markdown_email.json'
    support_path = Pathname.new(File.dirname(__FILE__))

    fixture_path = File.expand_path(File.join(support_path, '..', '..', 'spec', 'fixtures', file_name))
    email        = JSON.parse(File.read(fixture_path))

    user = User.create({
      :first_name => Faker::Name.first_name,
      :last_name  => Faker::Name.last_name,
      :email      => Faker::Internet.email,
      :provider   => 'google',
      :uid        => rand(0..9999)
    })

    email['FromFull']['Email'] = user.email

    Post.new_from_postmark(email.to_json).save
  end
end
