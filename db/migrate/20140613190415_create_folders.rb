class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.text :description
      t.string :role
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
