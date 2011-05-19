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
      path = @post.image_title.full_path
      assert File.exists?(path), "#{path} should exist"
    end

    context "with an existing post" do
      
      setup do
        @post = Post.create(:title => "Hello McPosty")
      end
         
      should "delete old image when changed and create a new one" do
        path = @post.image_title.full_path
        
        assert File.exists?(path)
        
        @post.title = "Another title!"
        @post.save
        
        assert !File.exists?(path), "#{path} shouldn't exist"
        
        new_path = @post.image_title.full_path
        
        assert_not_equal path, new_path
        
        assert File.exists?(new_path), "#{new_path} shouldn exist"
        
      end
    
    end
    
  end
    
end