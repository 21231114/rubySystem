class AddUserToSubjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :subjects, :user, null: false, foreign_key: true
  end
end
