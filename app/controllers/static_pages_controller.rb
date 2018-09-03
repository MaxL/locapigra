require 'facets/ostruct/to_ostruct'
class StaticPagesController < ApplicationController
  skip_authorization_check
  before_action :index_header, only: [:home]

  def home
    client = Tumblr::Client.new
    if client
      response = client.posts 'locapigra.tumblr.com', limit: 1, reblog_info: true, notes_info: true
      @posts = response.to_ostruct.posts
      @post = @posts.first.to_ostruct
    end
  end

  def about

  end

  def imprint

  end

  def toc

  end

  def thanks
    @token = params[:token]
  end

end
