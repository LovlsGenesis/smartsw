class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :cep
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :district

      t.belongs_to :user

      t.timestamps
    end
  end
end
