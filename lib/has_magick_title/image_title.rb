class ImageTitle < ActiveRecord::Base
  
  belongs_to :imagable, :polymorphic => true
  
  #before_save    :create_magick_title
  before_destroy :delete_magick_title
  
  
  
  validate :filename, :presence => true
  validate :width, :height, :size, :numericality => true
  
  

  def url
    File.join("/system/titles", filename)
  end
  
  def full_path
    File.join(Rails.root, "public", url)
  end
  
    
  private
  
    #def create_magick_title
    #
    #  puts "GENERATE!!"
    #
    #  puts "------"
    #  puts attributes.inspect  
    #end
  
    def delete_magick_title
      
      puts "CURRENT IMAGE DESTROY!"
      puts full_path.inspect
      
      FileUtils.rm(full_path) if File.exists?(full_path)
      
    end
    
end