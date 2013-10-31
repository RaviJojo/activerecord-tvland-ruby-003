class CreateCharacters < ActiveRecord::Migration

  def change
    create_table :characters do |c|
      c.string      :name
      c.string      :played_by
      c.string      :catchphrase
    end
  end

end

