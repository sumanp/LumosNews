class AddDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
    add_column :events, :cover_image, :string
  end
end
