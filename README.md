Has Magick Title
================
 
Installation
------------

Since has_magick_title is to be used with rails, we'll install it by adding the following to your Gemfile and running the `bundle` command.

    gem 'has_magick_title', :git => 'git://github.com/citrus/has_magick_title.git'
    
Now bundle up:

    bundle


Usage
-----

To automagically generate your model's title attribute into an image, just call the `has_magick_title` class method.

    # assume the defaults (:attribute => :title)
    class Post < ActiveRecord::Base
      has_magick_title      
    end
    

    # custom attribute and magick_title options
    class Person < ActiveRecord::Base
      has_magick_title :name,
        :color => "#e00053", 
        :font_size => 19
    end

    # custom attribute and magick_title style
    
    MagickTitle.style :h1 do
      font_size   50
      line_height -10
    end
        
    class Person < ActiveRecord::Base
      has_magick_title :name, :h1
    end


See [magick_title](https://github.com/citrus/magick_title) for more...


Testing
-------

Testing for has_magick_title is done with [shoulda](https://github.com/thoughtbot/shoulda), [spork](https://github.com/timcharper/spork) and [dummier](https://github.com/citrus/dummier).

Start by cloning the project:

    git clone git://github.com/citrus/has_magick_title.git
    cd has_magick_title
    
    
To get your environment setup, just run the following:

    bundle
    bundle exec dummier
    
    
Now run the unit tests with rake:

    rake
    
    
If you'd like to spork, you probably already know what to do. Otherwise, skip the rake step and run spork instead:

    spork
    

Now in another window:

    cd /to/where/you/cloned/has_magick_title
    testdrb test/unit/*.rb


License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.