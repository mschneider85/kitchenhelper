class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
