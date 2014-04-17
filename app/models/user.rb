class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  ROLES = %w[superadmin admin requestor]

  delegate :name, to: :company, prefix: true
         
  belongs_to :company
  has_many :customers
  has_many :service_requests
  has_many :notes
  
  validates :company_id, presence: true
  
  def has_role?(role_name)
    role.eql? role_name.to_s
  end
  
  def full_name
    "#{first_name} #{last_name}".squish
  end

  def admin?
    has_role?(:admin)
  end

  def self.admin_and_who_receive_communication
    where(role: 'admin', receives_communication: true)
  end
end
