require_relative '../test_helper'



class HasMagickTitleTest < Test::Unit::TestCase

  def setup
    # nada
  end
  
  should "have has_magick_title in active record's singleton_methods" do
    assert ActiveRecord::Base.singleton_methods.include?(:has_magick_title)
  end
  
  should "have a model that's called has_magick_title" do
    assert Post.singleton_methods.include?(:has_magick_title)
  end
    
  context "with a magick_title model" do
    
    setup do
      @post = Post.new(:title => "A posty post")
    end 
    
    should "have proper instance methods" do
      assert @post.respond_to?(:image_title)
      assert @post.respond_to?(:image_title=)
      assert @post.respond_to?(:has_image_title?)
      assert @post.respond_to?(:has_magick_title?)
      assert @post.respond_to?(:magick_title_options)
    end
    
    should "create title upon save" do
      assert @post.valid?
      assert @post.save
      assert_not_nil @post.image_title
      
      path = File.join(Rails.root, "public", @post.image_title.url)
      puts path
      assert File.exists?(path), "#{path} should exist"
      
    end
    
  end
  
  
  #should "have has_magick_title in singleton_methods" do
  #  assert Post.singleton_methods.include?(:has_magick_title)
  #end  
    
end