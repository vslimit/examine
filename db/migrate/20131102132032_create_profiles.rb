class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :dic_key
      t.string :dic_value
      t.string :dic_type

      t.timestamps
    end
  end
end
