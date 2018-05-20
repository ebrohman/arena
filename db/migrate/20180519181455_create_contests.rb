class CreateContests < ActiveRecord::Migration[5.0]
  enable_extension 'uuid-ossp'

  def change
    create_table :contests, id: :uuid do |t|
      t.references  :challenger, type: :uuid, null: false
      t.references  :opponent, type: :uuid, null: false
      t.string      :strategy, null: false
      t.references  :winner, type: :uuid
      t.timestamps
    end
  end
end
