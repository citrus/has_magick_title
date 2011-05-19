MagickTitle::Options.class_eval do
  
  # Alias the defaults for use later
  alias :standard_defaults :defaults
  
  # Overwrite defaults to include the attribute option
  def defaults
    standard_defaults.merge(:attribute => :title)
  end
    
end