class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  before_validation :name_to_downcase

  validates :name, uniqueness: true, presence: true

  private

  def name_to_downcase
    self.name = name.downcase
  end
end
