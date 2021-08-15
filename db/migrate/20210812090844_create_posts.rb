class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text       :map_link, null: false
      t.integer    :distance, null: false
      t.text       :text,     null: false
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
