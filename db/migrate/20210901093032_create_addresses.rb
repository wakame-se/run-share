class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer    :postal_code,     null: false
      t.integer    :prefecture_code, null: false
      t.string     :city,            null: false
      t.string     :street,          null: false
      t.references :post,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
