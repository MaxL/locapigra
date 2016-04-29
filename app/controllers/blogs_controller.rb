class BlogsController < ApplicationController
  def index
    client = Tumblr::Client.new :consumer_key => 'VOf3IKabebfz5hnyCn8dY0JVVX80cqQ1Zc8xzd7TDgOSeCSE51'
    response = client.posts 'locapigra.tumblr.com', limit: 5, reblog_info: true, notes_info: true
    @posts = response.to_ostruct
  end
end
