class RemoveDetailsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :score
    remove_column :users, :air
    remove_column :users, :exam_date
    remove_column :users, :reason
  end

  def down
    add_column :users, :reason, :string
    add_column :users, :exam_date, :string
    add_column :users, :air, :string
    add_column :users, :score, :int
  end
end
