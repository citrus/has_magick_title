require_relative '../test_helper'

class StyleTest < Test::Unit::TestCase

  def setup
    
    MagickTitle.style :h1 do
      font_size   50
      line_height -10
    end
        
    Post.class_eval do
      has_magick_title :title, :h1
    end
    
    @post = Post.create(:title => "A posty post")
    @image_title = @post.image_title
  end
  
  should "have proper defaults" do
    assert_not_nil @post
    assert_not_nil @image_title
  end
  
  should "have have style options" do
    assert_equal 50,  @post.magick_title_options[:font_size]
    assert_equal -10, @post.magick_title_options[:line_height]    
  end
  
end
