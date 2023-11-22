class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable#, skip: [:email_validation]
  has_many :subjects
  has_many :discussions
  attr_accessor :signin # 虚拟属性

  validates :username, presence: true
  validates :status, presence: true
  validates :num, presence: true
  # 对默认方法进行重写
  def email_required?
    false
  end
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if signin = conditions.delete(:signin)
      where(conditions.to_h).where(['lower(num) = :value',
                                    { value: signin.downcase }]).first
    elsif conditions.has_key?(:num)
      where(conditions.to_h).first
    end
  end
end
