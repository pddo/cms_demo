# typed: strict
class Role < ActiveRecord::Base
  has_many :admins, dependent: :restrict_with_error
  has_and_belongs_to_many :permissions

  validates_presence_of :name
  validates_length_of :name, in: 3..50
  validates_uniqueness_of :name
end
