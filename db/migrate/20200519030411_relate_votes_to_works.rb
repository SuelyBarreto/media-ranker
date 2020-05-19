class RelateVotesToWorks < ActiveRecord::Migration[6.0]
  def change
    # remove_column :votes, :work
    add_reference :votes, :work, index: true
  end
end
