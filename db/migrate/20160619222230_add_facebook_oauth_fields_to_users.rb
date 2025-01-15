class AddFacebookOauthFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
    add_column :users, :facebook_token, :string
    add_column :users, :facebook_secret, :string
    add_column :users, :facebook_raw_data, :text
  end
end
