class ImageTitle < ActiveRecord::Base
  
  belongs_to :imagable, :polymorphic => true
   
  # TODO
    
end