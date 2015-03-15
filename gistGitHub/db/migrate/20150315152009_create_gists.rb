class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :title
      t.text :description
      t.text :url
      t.string :username

      t.timestamps
    end
  end
end
