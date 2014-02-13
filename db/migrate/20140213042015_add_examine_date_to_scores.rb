class AddExamineDateToScores < ActiveRecord::Migration
  def change
    add_column :scores, :examine_date, :string
  end
end
