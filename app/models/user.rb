class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :trackable, :lockable, :registerable, :recoverable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  ROLES = %w(superadmin admin user)

  validates :first_name, :last_name, :role, :email, presence: true
  validates :role, inclusion: {in: ROLES}

  def name
    "#{first_name} #{last_name}"
  end
end
