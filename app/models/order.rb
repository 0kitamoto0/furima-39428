class Order < ApplicationRecord
  belongs_to :prefecture
  belongs_to :user
  belongs_to :item
  has_one :order_detail
end
