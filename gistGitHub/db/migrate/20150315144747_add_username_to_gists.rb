class AddUsernameToGists < ActiveRecord::Migration
  def change
    add_column :gists, :username, :string
  end
end
