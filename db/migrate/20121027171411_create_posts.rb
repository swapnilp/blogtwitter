class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :article
      t.string :post
      t.references :user
      t.timestamps
    end
  end
end
