class Video < ActiveRecord::Base
	has_many :ratings
	belongs_to :user
  validates_presence_of :panda_video_id

  def self.order_by_ratings

  end

  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end

  def average_rating
  	if ratings.size == 0
  		return 0
  	else
  		return ratings.sum(:score) / ratings.size
  	end
  end

  def user_rating(user)
    rating = Rating.where(video_id: self.id, user_id: user.id).first
    unless rating
      rating = Rating.create(video_id: self.id, user_id: user.id, score: 0)
    end
    rating
  end
end
