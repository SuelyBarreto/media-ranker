class CreateUsersWorksJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :users_works do |t|
      t.belongs_to :user, index: true
      t.belongs_to :work, index: true    
    end
  end
end
