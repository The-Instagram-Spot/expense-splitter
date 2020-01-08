class Group <  ActiveRecord::Base
    has_many :people, dependent: :destroy
    validates :group_name, presence: true, length: { minimum: 5}
end