class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  ROLES = %w[superadmin admin requestor]
         
  belongs_to :company
  has_many :customers
  has_many :service_requests
  
  validates :company_id, presence: true
  
  def has_role?(role_name)
    role.eql? role_name.to_s
  end
end
