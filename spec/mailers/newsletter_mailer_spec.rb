require 'spec_helper'

describe NewsletterMailer do
  let(:posts) { create_list(:post, 1) }
  let(:mail) { NewsletterMailer.weekly_newsletter(posts) }

  context "with multiple posts" do
    let(:posts) { create_list(:post, 2) }

    it 'sends to all the users' do
      expect(mail.to).to match_array(User.pluck(:email))
    end

    it "includes two posts" do
      expect(mail.body).to have_selector('div.wrapper', count: 2)
    end
  end

  context "with one post" do
    let(:expected_post) { posts.first }

    it 'includes link to post' do
      expect(mail.body).to have_selector("a[href='#{post_url(expected_post)}']", text: expected_post.title)
    end

    it "includes author's name" do
      expect(mail.body).to have_selector('div.header', text: expected_post.user.full_name)
    end

    it "includes post body" do
      expect(mail.body).to have_selector('div', text: expected_post.body)
    end
  end

  it 'includes klarna logo' do
    expect(mail.body).to have_selector('img[src="https://cdn.klarna.com/public/images/SE/logos/v1/basic/SE_basic_logo_std_blue-black.png?width=180&height=48"]')
  end

  it 'has width and height attributes on klarna logo' do
    expect(mail.body).to have_selector('img[width="180"][height="48"]')
  end
end