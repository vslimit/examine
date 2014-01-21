class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :score
      t.string :status
      t.string :reason
      t.string :card_no
      t.string :exam_date
      t.string :air

      t.timestamps
    end
  end
end
