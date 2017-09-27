class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
    	t.string :name
    	t.string :description
    	t.string :location
    	t.integer :price	
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end 
  end
end
