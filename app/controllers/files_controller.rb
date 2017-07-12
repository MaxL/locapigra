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
<<<<<<< HEAD
    send_file('#{ENV["RAILS_SHARED_ROOT"]}/downloads/clawsoffury.pdf',
=======
    send_file("#{ENV['RAILS_SHARED_ROOT']}/downloads/clawsoffury.pdf",
>>>>>>> 8b49d7df0f0057bbe43225215d6f5287de3b4ffb
              filename: "clawsoffury.pdf",
              type: "application/pdf"
    )
  end

  def clawsepub
<<<<<<< HEAD
    send_file('#{ENV["RAILS_SHARED_ROOT"]}/downloads/clawsoffury.epub',
=======
    send_file("#{ENV['RAILS_SHARED_ROOT']}/downloads/clawsoffury.epub",
>>>>>>> 8b49d7df0f0057bbe43225215d6f5287de3b4ffb
              filename: "clawsoffury.epub"
    )
  end

  def clawscbr
<<<<<<< HEAD
    send_file('#{ENV["RAILS_SHARED_ROOT"]}/downloads/clawsoffury.cbr',
              filename: "clawsoffury.cbr"
    )
=======
    send_file("#{ENV['RAILS_SHARED_ROOT']}/downloads/clawsoffury.cbr",
              filename: "clawsoffury.cbr"
    )
  end

  def clawsbundle
    send_file '#{ENV['RAILS_SHARED_ROOT']}/downloads/clawsoffury.zip'
>>>>>>> 8b49d7df0f0057bbe43225215d6f5287de3b4ffb
  end

  private
  def check_token
    redirect_to root_path, :flash => {:danger => "Bad link"} unless DownloadToken.where("token = ? and expires_at > ?", params[:token], Time.now).present?
  end
end
