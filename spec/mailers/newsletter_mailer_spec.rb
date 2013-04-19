require 'spec_helper'

describe NewsletterMailer do
  let(:posts) { create_list(:post, 1) }
  let(:mail) { NewsletterMailer.weekly_newsletter(posts) }

  context "with multiple posts" do
    let(:posts) { create_list(:post, 2) }

    it 'sends to all the users' do
      mail.to.should =~ User.pluck(:email)
    end

    it "should include two posts" do
      mail.body.should have_selector('div.wrapper', count: 2)
    end
  end

  context "with one post" do
    let(:expected_post) { posts.first }

    it 'includes link to post' do
      mail.body.should have_selector("div.wrapper div.header a[href='#{post_url(expected_post)}']", text: expected_post.title)
    end

    it "includes author's name" do
      mail.body.should have_selector('div.wrapper div.header', text: expected_post.user.full_name)
    end

    it "includes post body" do
      mail.body.should have_selector('div.wrapper div', text: expected_post.body)
    end
  end

  it 'should include klarna logo' do
    mail.body.should have_xpath("//img[contains(@src,'klarna_blue_logo.png')]")
  end
end