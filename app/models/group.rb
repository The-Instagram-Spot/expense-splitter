class Group <  ActiveRecord::Base
    has_many :memberships
    has_many :users, through: :memberships
    has_many :transactions, dependent: :destroy
    accepts_nested_attributes_for :users, allow_destroy: false
    #validates :group_name, presence: true, length: { minimum: 5}
end
