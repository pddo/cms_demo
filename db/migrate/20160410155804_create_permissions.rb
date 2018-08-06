class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :subject_class, null: false
      t.string :action, null: false
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
