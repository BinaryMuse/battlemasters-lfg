class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :kind
      t.string :name
      t.string :slug
      t.string :battlegroup

      t.timestamps
    end

    add_index :servers, :battlegroup
  end
end
