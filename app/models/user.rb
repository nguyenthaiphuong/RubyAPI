class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
          # , , :confirmable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :position
  belongs_to :dept
  belongs_to :role

  has_many :time_requests

  validates :name, presence: true, length: {maximum: Settings.maximum.name}
  validates :phone, presence: true, length: {maximum: Settings.maximum.phone}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: {maximum: Settings.maximum.email},
  #   format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  # validates :password, length: {minimum: Settings.minimum.password}, on: :create

  validates :position_id, presence:true
  validates :role_id, presence:true
  validates :dept_id, presence:true
end
