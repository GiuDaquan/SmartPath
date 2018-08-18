class Review < ApplicationRecord

    belongs_to :user

    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 300 }
    validates :rating,  presence: true, numericality: { only_integer: true , less_than_or_equal_to: 5, greater_than_or_equal_to: 0}

end
