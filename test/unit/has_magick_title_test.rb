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
      [:image_title, :image_title=, :has_image_title?, :has_magick_title?, :refresh_magick_title, :magick_title_options ].each do |method|    
        assert @post.respond_to?(method)
      end
    end
    
    should "create an image upon save" do
      assert @post.valid?
      assert @post.save
      assert_not_nil @post.image_title
      path = @post.image_title.full_path
      assert File.exists?(path), "#{path} should exist"
    end

    context "an existing post" do
      
      setup do
        @post = Post.create(:title => "Hello McPosty")
        @path = @post.image_title.full_path
      end
         
      should "do nothing if the attribute is unchanged" do
        @post.save
        new_path = @post.image_title.full_path 
        assert_equal @path, new_path
      end
      
      should "refresh if force option is given" do
        path = @post.image_title.full_path
        timestamp = File.new(path).mtime
        # allow for a time change
        sleep 1
        @post.send(:refresh_magick_title, :force => true)        
        assert timestamp < File.new(path).mtime
      end
      
      should "not refresh if force option is absent" do
        path = @post.image_title.full_path
        timestamp = File.new(path).mtime
        # allow for a time change
        sleep 1
        @post.send(:refresh_magick_title)
        assert_equal timestamp, File.new(path).mtime
      end
       
      should "delete the old image when changed and create a new one" do
        @post.title = "Another title!"
        @post.save
        assert !File.exists?(@path), "#{@path} shouldn't exist"
        new_path = @post.image_title.full_path
        assert_not_equal @path, new_path
        assert File.exists?(new_path), "#{new_path} should exist"
      end

      should "delete the image with the record" do
        @post.destroy
        assert !File.exists?(@path)
      end

    end
    
  end
    
end