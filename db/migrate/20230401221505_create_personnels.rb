class CreatePersonnels < ActiveRecord::Migration[7.0]
  def change
    create_table :personnels do |t|
      t.string :username, null: false
      t.string :pass, null: false
      t.string :name, null: false
      t.string :title, foreign_key: true, null: false
    end
  end
end
