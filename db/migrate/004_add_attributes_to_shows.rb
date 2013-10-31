class AddAttributesToShows < ActiveRecord::Migration

  def change
    change_table :shows do |s|
      s.string :season
      s.string :day
      s.string :genre
    end

  end


end
