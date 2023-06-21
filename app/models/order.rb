class Order < ApplicationRecord
  belongs_to :prefecture
  belongs_to :user
  has_one :order_detail
end
