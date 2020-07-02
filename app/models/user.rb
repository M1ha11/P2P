# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(80)       default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  role                   :integer          default("0")
#  provider               :string(150)
#  uid                    :string(10)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  DEFAULT_EMAIL = 'p2p@p2p.com'.freeze
  DEFAULT_ADDRESS = 'Coruscant'.freeze
  DEFAULT_PHONE_NUMBER = '+880 (05) 5535355'.freeze

  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable,
         omniauth_providers: %i[twitter facebook]

  has_one :profile, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :claims, dependent: :destroy
  has_many :loan_participants, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates :email, presence: true, format: { with: /\A(\S+)@(.+)\.(\S+)\z/i }
  validates :email, uniqueness: true, if: -> { provider.nil? || provider.blank? }
  enum role: %i[user admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || DEFAULT_EMAIL
      user.password = Devise.friendly_token[0, 20]
      user.build_profile(
        address: DEFAULT_ADDRESS,
        phone_number: DEFAULT_PHONE_NUMBER
      )
      user.skip_confirmation!
    end
  end

  def will_save_change_to_email?
    false
  end
end
