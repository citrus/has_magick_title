require 'magick_title'
require 'magick_title/extension'
require 'has_magick_title/image_title'
require 'has_magick_title/view_helper'

module HasMagickTitle

  module Base
  
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      def has_magick_title(attribute=:title, options={})
        include InstanceMethods
        
        cattr_accessor :magick_title_options
        
        if options.is_a? Symbol
          self.magick_title_options = MagickTitle.styles[options]
        elsif options.is_a? Hash      
          self.magick_title_options = MagickTitle.options.merge(options)
        else 
          raise ArgumentError, "has_magick_title options must be a Symbol or Hash"
        end
        
        self.magick_title_options.merge!(:attribute => attribute)
            
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
        
        self.image_title = build_image_title unless has_magick_title?
        
        if image_title.new_record? || send("#{magick_title_options[:attribute]}_changed?")
          image_title.send(:delete_magick_title)
          image = MagickTitle::Image.create(magick_title_text, magick_title_options)
          image_title.update_attributes(image.identify.merge(:filename => image.filename))
        end
                       
      end
        
    end
  
  end
  
end

ActiveRecord::Base.send(:include, HasMagickTitle::Base)
ActionView::Helpers.send(:include, HasMagickTitle::ViewHelper)
