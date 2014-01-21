class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :answer
      t.string :air
      t.string :code
      t.integer :category_id
      t.integer :subject_type

      t.timestamps
    end
  end
end
