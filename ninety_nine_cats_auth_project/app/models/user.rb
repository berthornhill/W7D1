class User < ApplicationRecord
    validates :user_name, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    after_initialize :set_session_token

    def password=(plain_text_password)
        @password = plain_text_password
        self.password_digest = BCrypt::Password.create(plain_text_password)
    end

    def is_password?(plain_text_password)
        b_crypt_password = BCrypt::Password.new(self.password_digest) 
        b_crypt_password.is_password?(plain_text_password)
    end
    
    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64(10)
    end

    def set_session_token
        self.session_token ||= SecureRandom::urlsafe_base64(10)
    end
end
