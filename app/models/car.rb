class Car < ApplicationRecord

    belongs_to :user

    validates :user_id, presence: true
    validates :model, presence: true, length: { maximum: 20 }
    validates :battery_capacity,  presence: true, numericality: { only_integer: true }

end
