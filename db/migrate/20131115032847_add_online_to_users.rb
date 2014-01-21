class AddOnlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :on_line, :string
  end
end
