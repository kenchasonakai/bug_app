class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :trackable

  validates :nickname, presence: true, length: { maximum: 50 }

  has_many :posts, dependent: :destroy

  def nickname_initial
    nickname.first.upcase
  end

  private

  # NOTE: IPアドレスを持ちたくなかったため、以下のメソッドをオーバーライド
  def update_tracked_fields(request)
    old_current, new_current = self.current_sign_in_at, Time.now
    self.last_sign_in_at     = old_current || new_current
    self.current_sign_in_at  = new_current
    self.sign_in_count ||= 0
    self.sign_in_count += 1
  end
end
