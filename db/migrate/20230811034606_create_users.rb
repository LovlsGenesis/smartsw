class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :token
      t.string :refresh_token
      t.datetime :token_expiration_date

      t.timestamps
    end
  end
end
