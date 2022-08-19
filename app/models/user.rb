class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_many :dogs
  has_one :location
  has_many :reviews

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :biography, length: { minimum: 6, maximum: 500 }

  # model methods
  def name
    [first_name, last_name].compact.join(" ")
  end
end
