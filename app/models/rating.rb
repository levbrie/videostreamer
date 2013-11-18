class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validate :ensure_not_creator

  def ensure_not_creator
    errors.add :user_id, "is the creator of the video" if video.user_id == user_id
  end
end
