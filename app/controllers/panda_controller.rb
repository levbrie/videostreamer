class PandaController < ApplicationController
  def verify_authenticity_token
    handle_unverified_request unless (form_authenticity_token == upload_payload['csrf'])
  end

  def upload_payload
    @upload_payload ||= JSON.parse(params['payload'])
  end

  def authorize_upload
    # ACCEPTABLE_CONTENT_TYPES = ['video/x-flv', 'video/mp4',
    #   'application/x-mpegURL', 'video/MP2T', 'video/3gpp',
    #   'video/quicktime', 'video/x-msvideo', 'video/x-ms-wmv']
    # payload = JSON.parse(params['upload_payload'])
    # unless ACCEPTABLE_CONTENT_TYPES.include?(payload['content_type'])
    #   redirect_to videos_url, alert: "That file format is not accepted!"
    # else
    upload = Panda.post('/videos/upload.json', {
      file_name: upload_payload['filename'],
      file_size: upload_payload['filesize'],
      profiles: "h264"
    })

    render :json => {:upload_url => upload['location']}
    # end
  end

  # added from Rails example
  def authorize_upload_postprocess

    upload = Panda.post('/videos/upload.json', {
      file_name: upload_payload['filename'],
      file_size: upload_payload['filesize'],
      profiles: "h264",
    })

    render :json => {:upload_url => upload['location'], :postprocess_url => "/videos/postprocess"}
  end
end
