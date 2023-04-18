class CreateLoginTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :login_tokens do |t|
      t.string :token, null: false, unique: true
      t.string :personnel_id, null: false, foreign_key: true, unique: true
    end
  end
end
