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

| Column             | Type   | Options                      |
| ------------------ | ------ | ---------------------------- |
| nickname           | string | null: false                  |
| email              | string | null: false unique_key: true |
| encrypted_password | string | null: false                  |
| last_name          | string | null: false                  |
| first_name         | string | null: false                  |
| last_name_kana     | string | null: false                  |
| first_name_kana    | string | null: false                  |
| date_of_birth      | date   | null: false                  |

### Association

- has_many :items
- has_many :orders, through: :items

## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| title        | string     | null: false                    |
| description  | text       | null: false                    |
| price        | integer    | null: false                    |
| category     | string     | null: false                    |
| condition    | string     | null: false                    |
| shipping_fee | string     | null: false                    |
| prefecture   | string     | null: false                    |
| days_to_ship | string     | null: false                    |

### Association

- belongs_to :user
- has_many :orders, through: :user

## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |
| credit_card_number | string     | null: false                    |
| expiration_date    | date       | null: false                    |
| security_code      | string     | null: false                    |
| postal_code        | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| street_address     | string     | null: false                    |
| building_name      | string     | null: false                    |
| phone_number       | string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :items