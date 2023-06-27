class OrderOrderDetail
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁ハイフン4桁」の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数字で入力してください' }
    validates :city
    validates :street_address
    validates :token
  end

  def save
    order = Order.create(item_id:, user_id:)
    OrderDetail.create(postal_code:, prefecture_id:, city:, street_address:,
                       building_name:, phone_number:, order_id: order.id)
  end
end
