class User < ApplicationRecord
	has_many :authentications, dependent: :destroy
  validates :password, presence: true, on: :create # only need password on create (doesnt apply to edit update)
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  enum role: { :customer => 0, :moderator => 1, :superadmin => 2 }

  include Clearance::User

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      name: auth_hash["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end
    # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end
end

    