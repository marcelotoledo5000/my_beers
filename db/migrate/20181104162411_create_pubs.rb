class CreatePubs < ActiveRecord::Migration[5.2]
  def change
    create_table :pubs do |t|
      t.string :name
      t.string :country
      t.string :state, limit: 2
      t.string :city

      t.timestamps
    end
  end
end
