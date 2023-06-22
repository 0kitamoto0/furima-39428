class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new, :create]
  
  def index
    @order_order_detail = OrderOrderDetail.new
  end

  def new
    @order_order_detail = OrderOrderDetail.new
  end

  def create
    @order_order_detail = OrderOrderDetail.new(order_params)
    if @order_order_detail.valid?
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_order_detail).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
