class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :sign
      t.string :content
      t.integer :subject_id

      t.timestamps
    end
  end
end
