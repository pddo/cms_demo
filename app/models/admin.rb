# typed: false
class Admin < ActiveRecord::Base
  belongs_to :role
  has_many :permissions, through: :role

  validates_presence_of :email, :login

  acts_as_authentic do |c|
    c.logged_in_timeout = 30.minutes
  end

  def set_password; nil; end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end
end
