class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :description
      t.references :users
      t.timestamps
    end
  end
end
