module HasMagickTitle
  module ViewHelper
  
    # Creates and HTML image tag with the options provided
    def magick_title_for(record, options={})
      opts = record.magick_title_options[:to_html].merge(options)
      record.refresh_magick_title unless record.has_image_title? 
      return "[magick_title error]" unless record.has_image_title?
      MagickTitle::Renderer.to_html(record.magick_title_text, record.image_title.url, opts).html_safe
    end        
  
  end
end
