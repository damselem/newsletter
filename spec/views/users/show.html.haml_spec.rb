require 'spec_helper'

describe "users/show" do
  let(:user) { create(:user) }
  let(:posts) { [] }
  before { assign(:user, user) }
  before { posts } #required so that the User's posts are created before the rendering

  context "with a post" do
    let(:posts) { create_list(:post, 1, user: user) }

    it "should link to the post" do
      render

      rendered.should have_selector("li a[href='#{post_path(posts.first)}']")
    end

    it "should have post title as link text" do
      render

      rendered.should have_selector('li a', text: posts.first.title)
    end
  end

  context "with multiple posts" do
    let(:posts) { create_list(:post, 2, user: user) }

    it "should have links to both posts" do
      render

      rendered.should have_selector('li a', count: 2)
    end

    context "where one post is archived" do
      before { posts.first.update_attribute(:archived, true) }

      it "should only show one post" do
        render

        rendered.should have_selector('li a', count: 1)
      end

      it "should link to active post" do
        active_post = posts.detect { |post| !post.archived? }
        render

        rendered.should have_selector("li a[href='#{post_path(active_post)}']")
      end
    end
  end
end