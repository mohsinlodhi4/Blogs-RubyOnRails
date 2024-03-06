class Reply < ApplicationRecord
  validates :content, presence: true 
  belongs_to :post
end
