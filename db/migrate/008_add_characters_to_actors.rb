class AddCharactersToActors < ActiveRecord::Migration

  def change 
    add_column :characters, :actor_id, :integer
    # change_table :characters do |a|
    # a.belongs_to :actors
    # end
  end

end
