class CreateBattlePets < ActiveRecord::Migration[5.0]
  enable_extension "uuid-ossp"

  def change
    create_table :battle_pets, id: :uuid do |t|
      t.string  :name
      t.integer :strength
      t.integer :speed
      t.integer :intelligence
      t.integer :integrity
      t.timestamps
    end
  end
end
