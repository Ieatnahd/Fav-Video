class Item < ApplicationRecord
  belongs_to :user
  
  validates :video_id, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :channel, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :thumbnail_url, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
end
