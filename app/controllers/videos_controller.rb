class VideosController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all.sort {|a, b| b.average_rating <=> a.average_rating}
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264"]
    @rating = Rating.where(video_id: @video.id, user_id: current_user.id).first
    unless @rating
      @rating = Rating.create(video_id: @video.id, user_id: current_user.id, score: 0)
    end
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # added from Rails example
  def postprocess
    video_params = JSON.parse(params["upload_response"])
    @video = Video.new(:panda_video_id => video_params["id"], :title => "Title-to-be-edited-later")

    if @video.save
      render :json => {:play_url => url_for(@video), :id => @video_id}
    end
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.create!(video_params)
    @video.user_id = current_user.id
    # may be necessary instead of below: redirect_to :action => :show, :id => @video.id
    redirect_to :action => :show, :id => @video.id
#    respond_to do |format|
#      if @video.save
#        format.html { redirect_to @video, notice: 'Video was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @video }
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @video.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @original_video.delete
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :panda_video_id)
    end
end
