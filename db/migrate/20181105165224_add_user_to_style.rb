class AddUserToStyle < ActiveRecord::Migration[5.2]
  def change
    add_reference :styles, :user, foreign_key: true
  end
end
