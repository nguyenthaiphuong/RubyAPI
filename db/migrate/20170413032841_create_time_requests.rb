class CreateTimeRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :time_requests do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :ot, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
