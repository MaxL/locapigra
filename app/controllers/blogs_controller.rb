class BlogsController < ApplicationController
  skip_authorization_check

  include ActiveModel::Conversion

  def index
    client = Tumblr::Client.new
    if client
      response = client.posts 'locapigra.tumblr.com', limit: 80, reblog_info: true, notes_info: true
      @posts = response.to_ostruct.posts.paginate(:page => params[:page], :per_page => 10)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
