class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text       :map_link, null: false
      t.float      :distance, null: false
      t.string     :course,   null: false
      t.string     :slope,    null: false
      t.string     :traffic,  null: false
      t.string     :crowd,    null: false
      t.string     :view,     null: false
      t.text       :comment,  null: false
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
