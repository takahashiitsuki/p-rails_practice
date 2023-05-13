class Book < ApplicationRecord
  scope :costly, -> { where("price > ?", 3000)}
  scope :written_about, ->(theme){where("name like ?", "%#{theme}%")}

  belongs_to :publisher

  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate do |book|
    if book.name.include?("exercise")
      book.errors[:name] << "I don't like execise."
    end
  end
  
  after_destroy do
    Rails.logger.info "Book is deleted: #{self.attributes}"
  end
  
  after_destroy :if => :high_price? do
    Rails.logger.warn "Book with high price is deleted: #{self.attributes}"
    Rails.logger.warn "Please check!!"
  end
  
  def high_price?
    price >= 5000
  end
end
