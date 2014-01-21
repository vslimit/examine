class AddTagToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :tag, :string
  end
end
