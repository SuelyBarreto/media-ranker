class RelateVotesToUsers < ActiveRecord::Migration[6.0]
  def change
    # remove_column :votes, :user
    add_reference :votes, :user, index: true
  end
end
