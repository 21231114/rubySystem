class Subject < ApplicationRecord
  validates :title, :info, presence: true
  has_many :discussions, dependent: :destroy
  has_many :relations
  has_many :users, through: :relations
end
