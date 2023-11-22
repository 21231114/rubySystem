class Discussion < ApplicationRecord
  validates :content, presence: true
  belongs_to :subject
  belongs_to :user
end
