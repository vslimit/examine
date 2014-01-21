class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :totle_score
      t.string :all_score
      t.string :status
      t.string :reason
      t.string :exam_date
      t.string :air
      t.string :subjects

      t.timestamps
    end
  end
end
