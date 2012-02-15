class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :faction
      t.string :character
      t.integer :race
      t.string :realm
      t.integer :character_class
      t.string :main_spec
      t.string :off_spec
      t.integer :rating
      t.string :rank
      t.integer :resilience
      t.integer :item_level
      t.string :irc_name
      t.text :notes

      t.timestamps
    end
  end
end
