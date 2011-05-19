module HasMagickTitle

  module Helper
  
    def magick_title_for(record, options={})
      record.refresh_magick_title unless record.has_image_title? 
      return "[magick_title error]" unless record.has_image_title?
      image_tag record.image_title.url, :alt => record.magick_title_text, :title => record.magick_title_text, :class => record.magick_title_text
    end
  
  end
     
end
