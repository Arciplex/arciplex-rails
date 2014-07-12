class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin requestor requestor_limited shipping_vendor]

  attr_accessor :temp_password

  delegate :name, to: :company, prefix: true

  belongs_to :company
  has_many :customers
  has_many :service_requests
  has_many :notes
  has_many :orders

  validates :company_id, presence: true

  before_create :generate_temp_password

  def has_role?(role_name)
    role.eql? role_name.to_s
  end

  def full_name
    "#{first_name} #{last_name}".squish
  end

  def admin?
    has_role?(:admin)
  end

  def restricted?
    has_role?(:requestor_limited)
  end

  def self.admin_and_who_receive_communication
    where(role: 'admin', receives_communication: true)
  end

  def notify
    UserMailerWorker.perform_async(self.id, self.temp_password)
  end

  private
    def generate_temp_password
      pwd = Devise.friendly_token
      self.temp_password = pwd
      self.password = pwd
      self.password_confirmation = pwd
    end

  protected
    def password_required?
      !new_record?
    end

end
