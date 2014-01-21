class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :pid
      t.string :code

      t.timestamps
    end
  end
end
