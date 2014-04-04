class Company < ActiveRecord::Base
  has_many :users

  scope :not_arciplex, -> { where "name != 'ArciPlex'" }
end