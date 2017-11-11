class AddStartTimeToOts < ActiveRecord::Migration[5.0]
  def change
    add_column :ots, :start_time, :datetime
    add_column :ots, :end_time, :datetime
  end
end
