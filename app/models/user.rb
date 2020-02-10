class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true

  has_many :photos, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
end
