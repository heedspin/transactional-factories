require File.dirname(__FILE__) + '/../test_helper'

require 'lib/blog_post'
require 'transactional_factories'

class TestBlogPost < Test::Unit::TestCase
  @@initial_blog_post = nil
  def self.setup
    @@initial_blog_post = BlogPost.create(:title => 'initial blog post')
  end

  def self.teardown
    raise 'Teardown unhappy' if @@initial_blog_post.nil?
    # Hard to assert on teardown since it's the last step.  How would you know it *didn't* happen?
  end
  
  def setup
    assert @@initial_blog_post
    assert_equal @@initial_blog_post, BlogPost.first
    BlogPost.create(:title => 'setup blog post')
  end
  
  def test_blog_post1
    assert_equal 2, BlogPost.count
    BlogPost.create(:title => 'blog post 1')
    assert_equal 3, BlogPost.count
  end
  
  def test_blog_post2
    assert_equal 2, BlogPost.count
    BlogPost.create(:title => 'blog post 2')
    assert_equal 3, BlogPost.count
  end
  
end
