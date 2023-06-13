# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false unique: true |
| encrypted_password | string | null: false              |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| date_of_birth      | date   | null: false              |

### Association

- has_many :items
- has_many :orders, through: :items

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| title           | string     | null: false                    |
| description     | text       | null: false                    |
| price           | integer    | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| shipping_fee_id | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| days_to_ship_id | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :orders, through: :users

## orders テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| item           | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :order_detail

## order_detail テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| order          | references | null: false, foreign_key: true |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| street_address | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |

### Association

- belongs_to :order