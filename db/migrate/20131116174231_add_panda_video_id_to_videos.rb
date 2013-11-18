class AddPandaVideoIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :panda_video_id, :string
    add_column :videos, :title, :string
  end
end
