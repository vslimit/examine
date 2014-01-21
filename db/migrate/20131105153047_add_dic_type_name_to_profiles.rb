class AddDicTypeNameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :dic_type_name, :string
  end
end
