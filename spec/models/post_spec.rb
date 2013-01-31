require 'spec_helper'

describe Post do
  include PostmarkEmailFaker

  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }


  describe '.new_from_postmark' do
    context 'given a user with email daniel@email.com exists' do
      before do
        create(:user, :email => 'daniel@email.com')
      end

      context 'given a postmark json from this user' do
        let(:postmark_json) { fake_email }

        before do
          Postmark::Mitt.any_instance.stub(:from_email).and_return('daniel@email.com')
        end

        it 'returns a valid post' do
          post = Post.new_from_postmark(postmark_json)

          expect(post).to be_valid
        end
      end
    end

    context 'given a postmark json from an non-existent user' do
      let(:postmark_json) { fake_email }

      before do
        Postmark::Mitt.any_instance.stub(:from_email).and_return('non.existent@email.com')
      end

      it 'returns an invalid post' do
        post = Post.new_from_postmark(postmark_json)

        expect(post).to_not be_valid
      end
    end
  end

  describe '.from_current_week' do
    context 'given there are no posts for the current week' do
      it 'returns no posts' do
        expect(Post.from_current_week).to have(0).posts
      end
    end

    context 'given there are 2 posts for the current week' do
      before do
        create_list(:post, 2)
      end

      it 'returns both posts' do
        expect(Post.from_current_week).to have(2).posts
      end
    end
  end

  describe '#archive' do
    context 'given a non-archived post' do
      let(:post) { create(:post, :archived => false) }

      before do
        post.archive
      end

      it 'marks it as archived' do
        expect(post.archived).to be_true
      end
    end

    context 'given an archived post' do
      let(:post) { create(:post, :archived => true) }

      before do
        post.archive
      end

      it 'keeps marked as archived' do
        expect(post.archived).to be_true
      end
    end
  end

  describe '.list' do
    context 'given there are 15 posts' do
      before do
        create_list(:post, 12)
        @archived_posts = create_list(:post, 3, :archived => true)
      end

      context 'given the requested page is 1' do
        let(:page)  { 1 }
        let(:posts) { Post.list(page) }

        it 'returns 10 posts' do
          expect(posts).to have(10).posts
        end
      end

      context 'given the requested page is 2' do
        let(:page)  { 2 }
        let(:posts) { Post.list(page) }

        it 'returns 2 posts' do
          expect(posts).to have(2).posts
        end

        it 'does not return archived posts' do
          expect(posts).to_not include(@archived_posts)
        end
      end
    end
  end

  describe '.show' do
    context 'given there is an archived Post' do
      before do
        create(:post, :id => 1, :archived => true)
      end

      it 'does not return a Post' do
        expect(Post.show(1)).to be_nil
      end
    end

    context 'given there is a non-archived Post' do
      before do
        @post = create(:post, :id => 1, :archived => false)
      end

      it 'returns a Post' do
        expect(Post.show(1)).to eq(@post)
      end
    end
  end
end
