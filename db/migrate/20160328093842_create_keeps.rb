class CreateKeeps < ActiveRecord::Migration
  def change
    create_table :keeps do |t|
      t.references :user, index: true, foreign_key: true
      t.references :kept, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
