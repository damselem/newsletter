class Email

  def initialize(json)
    @postmark = Postmark::Mitt.new(json)
  end

  def body
    @body ||= markdown.render(@postmark.text_body)
  end

  def user
    @user ||= User.where(:email => @postmark.from_email).first
  end

  private

  def markdown
    options = { :autolink => true, :space_after_headers => true }

    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  end

  def method_missing(meth, *args)
    if @postmark.respond_to?(meth)
      @postmark.send(meth, *args)
    else
      super
    end
  end

  def respond_to?(meth)
    @postmark.respond_to?(meth)
  end

end
