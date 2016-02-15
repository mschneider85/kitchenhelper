class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  before_validation :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :trackable, :lockable, :recoverable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def has_role?(role_sym = false)
    role_sym ? roles.any? { |r| r.name.underscore.to_sym == role_sym } : roles.count > 0
  end

  private

  def set_default_role
    self.roles << Role.find_by(name: :registered) if self.roles.empty?
  end

end
