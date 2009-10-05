ActiveRecord::Schema.define :version => 0 do
  create_table :tags, :force => true do |t|
    t.column :name, :string
    t.column :taggings_count, :integer, :default => 0, :null => false
  end
  add_index :tags, :name 
  add_index :tags, :taggings_count

  create_table :taggings, :force => true do |t|
    t.column :tag_id, :integer
    t.column :taggable_id, :integer
    t.column :taggable_type, :string
    t.column :owner_id, :integer

    t.foreign_key :owner_id, :owners, :id
  end
  add_index :taggings, [:tag_id, :taggable_type]
  add_index :taggings, [:owner_id, :tag_id, :taggable_type]
  add_index :taggings, [:taggable_id, :taggable_type]
  add_index :taggings, [:owner_id, :taggable_id, :taggable_type]

  create_table :things, :force => true do |t|
    t.column :name, :string
  end

  create_table :owners, :force => true do |t|
    t.column :name, :string
  end
end