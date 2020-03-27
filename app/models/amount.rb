class Amount < ApplicationRecord
    belongs_to :tx, class_name: 'Transaction'
    belongs_to :user
end
