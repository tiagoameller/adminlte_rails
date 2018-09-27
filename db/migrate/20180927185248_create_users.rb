class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.date :dob
      t.boolean :active

      t.timestamps
    end
  end
end
