class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :validatable

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password, presence: true
  validates_confirmation_of :password

  protected

  def confirmation_required?
    false
  end
end
