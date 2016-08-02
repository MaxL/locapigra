class BlogsController < ApplicationController
  skip_authorization_check

  def index
    client = Tumblr::Client.new :consumer_key => 'VOf3IKabebfz5hnyCn8dY0JVVX80cqQ1Zc8xzd7TDgOSeCSE51'
    response = client.posts 'locapigra.tumblr.com', limit: 40, reblog_info: true, notes_info: true
    puts response
    @posts = response.to_ostruct.posts.paginate(page: params[:page], per_page: 10)
  end
end
