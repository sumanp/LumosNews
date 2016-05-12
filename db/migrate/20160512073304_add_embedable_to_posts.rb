class AddEmbedableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :embedable, :text
  end
end
