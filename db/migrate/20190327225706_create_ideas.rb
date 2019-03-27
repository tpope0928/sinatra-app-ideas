class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |i|
      i.string :content
      i.integer :user_id
    end
  end
end
