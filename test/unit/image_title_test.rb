require_relative '../test_helper'

class ImageTitleTest < Test::Unit::TestCase

  def setup
    @post = Post.create(:title => "A posty post")
    @image_title = @post.image_title
  end
  
  should "have proper defaults" do
    assert_not_nil @post
    assert_not_nil @image_title
  end
  
  should "have proper instance methods" do
    [ :url, :full_path ].each do |method|    
      assert @image_title.respond_to?(method)
    end
  end
  
  should "have proper protected delete method" do
    assert !@image_title.respond_to?(:delete_magick_title)
    assert @image_title.private_methods.include?(:delete_magick_title)
  end
  
end
