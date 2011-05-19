require 'magick_title'
require 'magick_title/extension'
require 'has_magick_title/image_title'


module HasMagickTitle

  module Base
  
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      def has_magick_title(options={})
        include InstanceMethods
        
        cattr_accessor :magick_title_options
        self.magick_title_options = MagickTitle.options.merge(options)
        
        has_one :image_title, :as => :imagable, :autosave => true, :dependent => :destroy
        before_save :refresh_magick_title
                
      end
    
    end
    
    module InstanceMethods
    
      def has_magick_title?
        !image_title.nil?
      end
      alias :has_image_title? :has_magick_title?
    
      def magick_title_text
        send magick_title_options[:attribute]
      end
      
      def refresh_magick_title
        
        if !has_magick_title?
          image = MagickTitle::Image.create(magick_title_text, magick_title_options)
          create_image_title(image.identify.merge(:filename => image.filename))
        elsif send("#{magick_title_options[:attribute]}.changed?")
          puts "TITLE CHANGED"
        else
          puts "NO CHANGE"
        end
        #image = MagickTitle::Image.create(magick_title_text, magick_title_options)
        #update(image.identify)
      
      
        #create_image_title(:title => )
        #  image_title.update_attributes(attrs)
        #else
        #  image_title = 
        #end                
      end
        
    end
  
  end
  
  module Helper
  
    def magick_title_for(record, options={})
      record.refresh_magick_title unless record.has_image_title? 
      return "[magick_title error]" unless record.has_image_title?
      image_tag record.image_title.url, :alt => record.magick_title_text, :title => record.magick_title_text, :class => record.magick_title_text
    end
  
  end
     
end


ActiveRecord::Base.send(:include, HasMagickTitle::Base)
ActionView::Helpers.send(:include, HasMagickTitle::Helper)