class CreateReimbursementRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :reimbursement_requests do |t|
      t.integer :personnel_id, foreign_key: true, null: false
      t.decimal :request_amount, precision: 10, scale: 2, null: false
      t.string :subject, null: false
      t.string :request
      t.integer :status, default: 0, null: false
      t.integer :manager_id, foreign_key: true
      t.string :manager_comment

    end
  end
end
