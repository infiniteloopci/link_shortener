class AddViewCountToLinks < ActiveRecord::Migration
  def change
    add_column :links, :view_count, :integer
  end
end
