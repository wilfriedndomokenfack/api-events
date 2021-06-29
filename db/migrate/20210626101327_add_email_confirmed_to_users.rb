class AddEmailConfirmedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_confirmed, :boolean, default: false
  end
end
