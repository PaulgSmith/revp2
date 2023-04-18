class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.decimal :salary, precision: 10, scale: 2, null: false

    end
  end
end
