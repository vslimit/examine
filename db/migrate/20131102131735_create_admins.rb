class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :login
      t.string :password_digest
      t.string :role
      t.string :name

      t.timestamps
    end
  end
end
