class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @tweet = Tweet.new
  end
end
