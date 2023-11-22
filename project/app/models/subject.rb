class Subject < ApplicationRecord
    validates :title, :info, presence: true
    has_many :discussions, dependent: :destroy
    belongs_to :user
end
