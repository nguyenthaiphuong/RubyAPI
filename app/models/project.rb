class Project < ApplicationRecord
  has_many :ots

  validates :name, presence: true, length: {maximum: Settings.maximum.name}
  validates :description, presence: true, length: {maximum: Settings.maximum.description}
end
