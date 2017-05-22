class StaticPagesController < ApplicationController
  skip_authorization_check
  before_filter :index_header, only: [:home]

  def home
    client = Tumblr::Client.new
    response = client.posts 'locapigra.tumblr.com', limit: 3, reblog_info: true, notes_info: true
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

  def toc

  end

  def thanks

  end
end
