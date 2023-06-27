require 'rails_helper'

RSpec.describe OrderOrderDetail, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_order_detail = FactoryBot.build(:order_order_detail, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_order_detail).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_order_detail.building_name = ''
        expect(@order_order_detail).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では投稿できない' do
        @order_order_detail.token = ''
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では投稿できない' do
        @order_order_detail.postal_code = ''
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空では投稿できない' do
        @order_order_detail.prefecture_id = 1
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では投稿できない' do
        @order_order_detail.city = ''
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では投稿できない' do
        @order_order_detail.street_address = ''
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が空では投稿できない' do
        @order_order_detail.phone_number = ''
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("Phone number can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」でないと投稿できない' do
        @order_order_detail.postal_code = '1234567' # 不正な郵便番号を設定
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include('Postal code は「3桁ハイフン4桁」の形式で入力してください')
      end
      it '郵便番号は、半角文字列のみでないと投稿できない' do
        @order_order_detail.postal_code = '１２３４５６７' # 不正な郵便番号を設定
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include('Postal code は「3桁ハイフン4桁」の形式で入力してください')
      end
      it '電話番号は、10桁以上でないと投稿できない' do
        @order_order_detail.phone_number = '123456789' # 不正な電話番号を設定
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include('Phone number は10桁以上11桁以内の半角数字で入力してください')
      end
      it '電話番号は、11桁以内でないと投稿できない' do
        @order_order_detail.phone_number = '123456789123' # 不正な電話番号を設定
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include('Phone number は10桁以上11桁以内の半角数字で入力してください')
      end
      it '電話番号は、半角数値のみでないと投稿できない' do
        @order_order_detail.phone_number = '１２３４５６７８９' # 不正な電話番号を設定
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include('Phone number は10桁以上11桁以内の半角数字で入力してください')
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @order_order_detail.user_id = nil
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("User can't be blank")
      end
      it '商品が紐付いていなければ投稿できない' do
        @order_order_detail.item_id = nil
        @order_order_detail.valid?
        expect(@order_order_detail.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
