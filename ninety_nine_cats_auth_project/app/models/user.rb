class User < ApplicationRecord
    validates :user_name, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    after_initialize :set_session_token

    def reset_session_token!
        session_token = SecureRandom::base64(10)
    end

    def set_session_token
    end
end
