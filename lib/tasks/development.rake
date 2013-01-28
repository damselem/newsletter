desc 'Add some fake emails'
task :fake_emails => :environment do
  file_name    = 'markdown_email.json'
  support_path = Pathname.new(File.dirname(__FILE__))

  file  = File.expand_path(File.join(support_path, '..', '..', 'spec', 'fixtures', file_name))
  email = File.read(file)

  Post.new_from_postmark(email).save
end
