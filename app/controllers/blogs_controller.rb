class BlogsController < ApplicationController
  skip_authorization_check

  def index
    client = Tumblr::Client.new
    response = client.posts 'locapigra.tumblr.com', limit: 40, reblog_info: true, notes_info: true
    @posts = response.to_ostruct.posts.paginate(page: params[:page], per_page: 10)
  end
end
