class CreateEmailOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :email_otps do |t|
      t.integer :pin
      t.references :user, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
