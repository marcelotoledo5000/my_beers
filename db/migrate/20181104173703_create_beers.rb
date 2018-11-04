class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.references :style, foreign_key: true
      t.string :abv
      t.string :ibu
      t.string :nationality
      t.string :brewery
      t.text :description

      t.timestamps
    end
  end
end
