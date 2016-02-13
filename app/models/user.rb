class User < ActiveRecord::Base
  belongs_to :role
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :trackable, :lockable, :recoverable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, :password, :password_confirmation, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end

end
