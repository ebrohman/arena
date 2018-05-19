class CreateContests < ActiveRecord::Migration[5.0]
  enable_extension 'uuid-ossp'

  def change
    create_table :contests, id: :uuid do |t|
      t.uuid :challenger_id
      t.uuid :opponent_id
      t.string :outcome
      t.timestamps
    end
  end
end
