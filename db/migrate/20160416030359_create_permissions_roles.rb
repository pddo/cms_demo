# typed: true
class CreatePermissionsRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions_roles do |t|
      t.belongs_to :role
      t.belongs_to :permission
    end
  end
end
