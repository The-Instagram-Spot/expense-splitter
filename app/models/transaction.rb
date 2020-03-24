class Transaction < ActiveRecord::Base
    belongs_to :group
    has_many :amounts
    has_many :users, through: :amounts
end
