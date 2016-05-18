class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.date :birthday
      t.string :tel
      t.string :location
      t.text :bio
    end
  end
end
