class AddActsAsTaggableTables < ActiveRecord::Migration 
  def self.up
    create_table :tags do |t|
      t.column :name, :string
      t.column :taggings_count, :integer, :default => 0, :null => false
    end
    add_index :tags, :name
    add_index :tags, :taggings_count

    create_table :taggings do |t|
      t.column :tag_id, :integer
      t.column :taggable_id, :integer
      t.column :taggable_type, :string
      t.column :owner_id, :integer

      t.foreign_key :owner_id, :owners, :id
    end

    # Find objects for a tag
    add_index :taggings, [:tag_id, :taggable_type]
    add_index :taggings, [:owner_id, :tag_id, :taggable_type]
    # Find tags for an object
    add_index :taggings, [:taggable_id, :taggable_type]
    add_index :taggings, [:owner_id, :taggable_id, :taggable_type]
  end

  def self.down
    drop_table :tags
    drop_table :taggings
  end
end