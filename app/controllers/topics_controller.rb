class TopicsController < ApplicationController
  def index
    flash.now[:info] = 'hello world'
  end
end
