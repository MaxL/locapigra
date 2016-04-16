class StaticPagesController < ApplicationController
  before_filter :index_header, only: [:home]

  def home
  end

  def comics
  end

  def shop

  end

  def blog

  end

  def about

  end
end
