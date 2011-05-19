module HasMagickTitle
  module Generators
    class InstallGenerator < Rails::Generators::Base 
        include Rails::Generators::Migration      
    
      def self.count!
        @count ||= 0
        (@count += 1) * 3
      end
    
      def self.next_migration_number(path)
        @time ||= Time.new.utc
        if ActiveRecord::Base.timestamped_migrations
          (@time + self.count!).strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
      desc "Installs required migrations for spree_essentials"
      source_root File.expand_path("../../templates", __FILE__)
      
      def copy_migrations
        migration_template "add_has_magick_title.rb", "db/migrate/add_has_magick_title.rb"
      end
    end
  end
end