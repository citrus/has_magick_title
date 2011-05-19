run "rails g scaffold post title:string"

gsub_file "app/models/post.rb", "end", %(
  has_magick_title
  
end)

gsub_file "config/routes.rb", "resources :posts", %(
  resources :posts
  root :to => "posts#index")

gsub_file "app/views/posts/show.html.erb", "<%= @post.title %>", %(
  <%= magick_title_for @post %>)
