prepend_file 'config/application.rb', %(require "rake"
)

run "rails g scaffold post title:string"

gsub_file "app/models/post.rb", "end", %(
  has_magick_title
  
end)

gsub_file "config/routes.rb", "resources :posts", %(
  resources :posts
  root :to => "posts#index")

gsub_file "app/views/posts/show.html.erb", "<%= @post.title %>", %(
  <%= magick_title_for @post %>)
   

say_status 'copying', 'sample fonts to dummy'
FileUtils.cp_r File.join(root_path, "test/fonts"), destination_path
