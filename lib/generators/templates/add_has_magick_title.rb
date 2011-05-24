class AddHasMagickTitle < ActiveRecord::Migration
  def self.up
    create_table :image_titles do |t|
      t.references :imagable, :polymorphic => true
      t.string     :text
      t.string     :filename
      t.integer    :width
      t.integer    :height
      t.integer    :size
    end
  end

  def self.down
    drop_table :image_titles
  end
end