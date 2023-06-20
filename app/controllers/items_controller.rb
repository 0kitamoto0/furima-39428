class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :require_login, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    return if current_user == @item.user

    redirect_to root_path, alert: '編集権限がありません'
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def require_login
    return if user_signed_in?

    redirect_to user_session_path, alert: 'ログインが必要です'
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :days_to_ship_id, :image).merge(user_id: current_user.id)
  end
end
