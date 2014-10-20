class CreateUrls < ActiveRecord::Migration
  def up
    create_table(:urls) do |t|
      
      t.string :stub, :null => false
      t.text :destination

      t.timestamps
    end
    
    add_index :urls, :stub, :unique => true
  end
  
  def down
    drop_table :urls
  end
end
