class ImageTitle < ActiveRecord::Base
  
  belongs_to :imagable, :polymorphic => true
  
  before_destroy :delete_magick_title
  
  validate :filename, :presence => true
  validate :width, :height, :size, :numericality => true
  
  def url
    File.join("/system/titles", filename)
  end
  
  def full_path
    File.join(Rails.root, "public", url)
  end
   
  def delete_magick_title
    return if new_record? || !File.exists?(full_path)
    FileUtils.rm(full_path)
  end
    
end