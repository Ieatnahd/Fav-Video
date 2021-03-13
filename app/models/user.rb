class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :item 
  
  def  favorite(item)
    self.favorites.find_or_create_by(item_id: item.id)    
  end
  
  def unfavorite(item)
    favorite = self.favorites.find_by(item_id: item.id)
    favorite.destroy if favorite
  end
  
  def likes?(item)
    self.likes.include?(item)
  end
end
