class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable # , skip: [:email_validation]
  has_many :discussions, dependent: :destroy
  attr_accessor :signin # 虚拟属性

  validates :username, presence: true
  validates :status, presence: true
  validates :num, presence: true
  validate :status_match # 学工号和身份要匹配，学工号位数合法

  has_many :relations,dependent: :destroy
  has_many :subjects, through: :relations
  def status_match
    if num.length != 8 && num.length!=6
      errors.add('学工号', '应为6位或8位的数字')
    end
    num.chars.each do |c|
      if c>'9'|| c<'0'
        errors.add('学工号', '应为6位或8位的数字')
      end
    end
    if (num.length == 8&&status=="teacher")||(num.length==6&&status=="student")
      errors.add('身份', '与学工号不匹配')
    end
  end

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
