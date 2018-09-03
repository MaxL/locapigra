require 'facets/ostruct/to_ostruct'
class BlogsController < ApplicationController
  skip_authorization_check

  include ActiveModel::Conversion

  def index
    client = Tumblr::Client.new
    if client
      @offset = params[:offset]
      if @offset
        @page = (@offset.to_i / 10) + 1
      end
      @posts = client.posts('locapigra.tumblr.com', limit: 10, offset: @offset).to_ostruct.posts
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
