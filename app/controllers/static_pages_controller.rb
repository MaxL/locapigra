class StaticPagesController < ApplicationController
  before_filter :index_header, only: [:home]

  def home
    client = Tumblr::Client.new :consumer_key => 'VOf3IKabebfz5hnyCn8dY0JVVX80cqQ1Zc8xzd7TDgOSeCSE51'
    response = client.posts 'locapigra.tumblr.com', limit: 1, reblog_info: true, notes_info: true
    puts response
    @posts = response.to_ostruct.posts
  end

  def comics
  end

  def shop

  end

  def blog

  end

  def about

  end

  def imprint

  end
end
