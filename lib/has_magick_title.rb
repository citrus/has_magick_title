require 'magick_title'

module HasMagickTitle

  module Base
  
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      def has_magick_title(options={})
        include InstanceMethods
        
        #self.set_options(HasImageTitle.default_options.merge(options))
        
        puts options.inspect
        
        has_one :image_title, :as => :imagable, :dependent => :destroy
        
        after_save :refresh_magick_title
        
      end
    
    end
    
    module InstanceMethods
    
      def has_image_title?
        self.image_title != nil
      end
      
      def refresh_magick_title
        
      end
        
    end
  
  end
  
  module Helper
  
    def magick_title_for(record, options={})
      puts record.inspect
      MagickTitle.say(record.title).to_html.html_safe
    end
  
  end
     
end


ActiveRecord::Base.send(:include, HasMagickTitle::Base)
ActionView::Helpers.send(:include, HasMagickTitle::Helper)