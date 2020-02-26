class Group <  ActiveRecord::Base
    has_many :transactions, dependent: :destroy
    has_many :memberships
    has_many :users, through: :memberships
    validates :group_name, presence: true, length: { minimum: 5}
end
