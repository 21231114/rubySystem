class AddSubjectRefToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_reference :discussions, :subject, null: false, foreign_key: true
  end
end
