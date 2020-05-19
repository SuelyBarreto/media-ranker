class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.date :voted_on

      t.timestamps
    end
  end
end
