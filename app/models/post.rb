class Post < ApplicationRecord
    validates :body, presence: true # validates that body is required

    has_many :replies, dependent: :destroy # replies will have post_id. if post is deleted, then delete reply as well
end
