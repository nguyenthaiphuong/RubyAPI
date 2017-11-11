class Dept < ApplicationRecord
  has_many :users

  validates :name, presence: true, length: {maximum: Settings.maximum.name}
end
