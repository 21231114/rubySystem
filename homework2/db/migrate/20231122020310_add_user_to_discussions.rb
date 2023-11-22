class AddUserToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_reference :discussions, :user, null: false, foreign_key: true
  end
end
