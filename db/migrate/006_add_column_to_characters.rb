class AddColumnToCharacters < ActiveRecord::Migration

  def change
    change_table :characters do |c|
      c.belongs_to :show
    end
  end
end