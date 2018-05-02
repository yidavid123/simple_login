class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "full_name", :limit => 50
      t.string "street_address"
      t.string "city"
      t.string "state"
      t.string "postal_code"
      t.string "country"
      t.string "email_address"
      t.string "username", :limit => 40
      t.string "password", :limit => 40
      t.float  "latitude"
      t.float  "longitude"
      t.timestamps
    end
  end
end
