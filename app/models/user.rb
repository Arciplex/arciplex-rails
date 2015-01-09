class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

    ROLES = %w(admin client_innovator client_innovator_limited)

    attr_accessor :temp_password

    has_many :company_users
    has_many :companies, through: :company_users
    has_many :customers
    has_many :service_requests
    has_many :notes
    has_many :orders
    has_many :permissions

    accepts_nested_attributes_for :companies, :permissions

    before_create :generate_temp_password

    def full_name
        "#{first_name} #{last_name}".squish
    end

    def save_and_notify
        save && notify
        true
    end

    def admin?
        role.eql? "admin"
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
            false
        end

end
