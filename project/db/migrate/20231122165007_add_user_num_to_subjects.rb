class AddUserNumToSubjects < ActiveRecord::Migration[7.1]
  def change
    add_column :subjects, :usernum, :string
  end
end
