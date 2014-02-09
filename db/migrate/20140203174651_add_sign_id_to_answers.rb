class AddSignIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :sign_id, :string
  end
end
