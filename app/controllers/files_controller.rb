class FilesController < ApplicationController
  skip_authorization_check #only: [:index, :show]
  protect_from_forgery :except => [:clawsoffury]
  before_action :check_token, except: [:clawsoffury]

  def clawsoffury
    @token = params[:custom]
    #@token = DownloadToken.create(:expires_at => Time.now + 24.hours)
    redirect_to action: 'download', token: @token
  end

  def download
    @token = params[:token]
  end

  def clawspdf
    send_file "/home/ec2-user/locapigra/shared/clawsoffury.pdf", type: "application/pdf", stream: true, x_sendfile: true#, disposition: 'inline'
  end

  def clawsepub
    send_file '/home/ec2-user/locapigra/current/downloads/clawsoffury.epub'
  end

  def clawscbr
    send_file '/home/ec2-user/locapigra/current/downloads/clawsoffury.cbr'
  end

  def clawsbundle
    send_file '/home/ec2-user/locapigra/current/downloads/clawsoffury.zip'
  end

  private
  def check_token
    redirect_to root_path, :flash => {:danger => "Bad link"} unless DownloadToken.where("token = ? and expires_at > ?", params[:token], Time.now).present?
  end
end
