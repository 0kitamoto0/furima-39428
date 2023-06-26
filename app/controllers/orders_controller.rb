class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new, :create]
  before_action :check_item_ownership, only: [:index, :new]
  
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_order_detail = OrderOrderDetail.new
  end

  def new
    @order_order_detail = OrderOrderDetail.new
  end

  def create
    @order_order_detail = OrderOrderDetail.new(order_params)
    if @order_order_detail.valid?
      pay_item
      @order_order_detail.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_order_detail).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:order_order_detail][:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:order_order_detail][:token],
      currency: 'jpy'
    )
  end

  def check_item_ownership
    @item = Item.find(params[:item_id])
    if current_user == @item.user_id || Order.exists?(item_id: @item.id)
      redirect_to root_path
    end
  end
end
