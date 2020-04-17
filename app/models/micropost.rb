class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  before_save :user_reply

  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    def user_reply
      reply_to = nil
      if content.include?("@")
        reply_to = content.split(/(@|\s)/)[content.split(/(@|\s)/).index("@") + 1]
      end
      if not(reply_to.nil?)
        self.in_reply_to = reply_to
      end
      #debugger
    end

end
