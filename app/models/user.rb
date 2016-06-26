class User < ActiveRecord::Base # :nodoc:
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :with_oauth?
  validates :email, uniqueness: { message: 'That email is taken.'     },
                    presence:   { message: 'Please provide an email!' },
                    format: VALID_EMAIL_REGEX,
                    unless: :with_oauth?

  serialize :twitter_raw_data, Hash

  has_many :challenge_actions, dependent: :destroy
  has_many :users_challenges, through: :challenge_actions, source: :challenge

  has_many :members, dependent: :destroy
  has_many :memberships, through: :members, source: :team

  def full_name
    "#{first_name} #{last_name}"
  end

  def with_oauth?
    provider.present? && uid.present?
  end

  def self.find_or_create_with_twitter(omniauth_data)
    user = User.where(provider: 'twitter', uid: omniauth_data['uid']).first
    unless user
      full_name = omniauth_data['info']['name']
      user = User.create(first_name: extract_first_name(full_name),
                         last_name: extract_last_name(full_name),
                         provider: 'twitter',
                         uid: omniauth_data['uid'],
                         password: SecureRandom.hex(16),
                         twitter_token: omniauth_data['credentials']['token'],
                         twitter_secret: omniauth_data['credentials']['secret'],
                         twitter_raw_data: omniauth_data)
    end
    user
  end

  def self.find_or_create_with_facebook(omniauth_data)
  user = User.where(provider: 'facebook', uid: omniauth_data['uid']).first
  unless user
    full_name = omniauth_data['info']['name']
    user = User.create!(first_name:      extract_first_name(full_name),
                        last_name:        extract_last_name(full_name),
                        provider:         'facebook',
                        uid:              omniauth_data['uid'],
                        password:         SecureRandom.hex(16),
                        facebook_token:    omniauth_data['credentials']['token'],
                        facebook_secret:   omniauth_data['credentials']['secret'],
                        facebook_raw_data: omniauth_data)
    end
    user
  end

  private

  def self.extract_first_name(full_name)
    if full_name.rindex(' ')
      full_name[0..full_name.rindex(' ') - 1]
    else
      full_name
    end
  end

  def self.extract_last_name(full_name)
    if full_name.rindex(' ')
      full_name.split.last
    else
      ''
    end
  end

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex(32)
    end while User.exists?(api_key: api_key)
  end
end
