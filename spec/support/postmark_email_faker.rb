module PostmarkEmailFaker
  def fake_email
    path = fake_email_path

    File.read(path)
  end

  def fake_markdown_email(attributes = {})
    path = fake_email_path(:markdown_email)

    File.read(path)
  end

  private

  def fake_email_path(name = :email)
    file_name    = "#{name}.json"
    support_path = Pathname.new(File.dirname(__FILE__))

    File.expand_path(File.join(support_path, '..', 'fixtures', file_name))
  end
end
