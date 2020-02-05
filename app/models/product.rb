class Product < ApplicationRecord
   has_many :items
    validates :unicode, format: { with: /[a-z]{3}\d{6}/, message: 'Debe tener 3 numeros y luego 6 letras'}
    validates :unicode, presence: true, uniqueness: true
    validates :descrip, presence: true, length: { maximum: 200 }
    validates :detail, presence: true
    validates :price, presence: true
   
    def self.get_scarce
     prods = Product
      .select("products.*, COUNT(items.id) as items_count")
      .joins('LEFT JOIN items ON (products.id = items.product_id)')
      .having('COUNT(items.id) >= 0 AND COUNT(items.id) < 6')
      .group(:id)
    end
    
    def self.get_in_stock
     prods = Product
      .select("products.*, COUNT(items.id) as items_count")
      .joins('LEFT JOIN items ON (products.id = items.product_id)')
      .having('COUNT(items.id) >= 0')
      .group(:id)
    end
    
    def self.get_all
     prods = Product
      .select("products.*, COUNT(items.id) as items_count")
      .joins('LEFT JOIN items ON (products.id = items.product_id)')
      .group(:id)
    end

    def self.createItems(product, create)
      create.to_i.times {Item.create!(product_id: product, status: 'Disponible', created_at: Time.now.utc, updated_at: Time.now.utc)}
    end
   
   def self.enough(needed)
    enough = {}
    needed.each { |k, v| enough[k] = (Product.productStock(k) > v.to_i) }
    !enough.value?(false)
  end
 
end
