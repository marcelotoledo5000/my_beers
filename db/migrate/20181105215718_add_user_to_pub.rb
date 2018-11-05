class AddUserToPub < ActiveRecord::Migration[5.2]
  def change
    add_reference :pubs, :user, foreign_key: true
  end
end
