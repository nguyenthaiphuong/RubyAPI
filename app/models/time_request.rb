class TimeRequest < ApplicationRecord
  belongs_to :ot
  belongs_to :user

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :user_id, presence: true
  validates :ot_id, presence: true
end
