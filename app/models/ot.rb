class Ot < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :request_times

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :description, presence: true, length: {maximum: Settings.maximum.description}
end
