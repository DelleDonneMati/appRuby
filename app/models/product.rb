class Product < ApplicationRecord
    validates :unicode, presence: true, uniqueness: true
    validates :descrip, presence: true, length: { maximum: 200 }
    validates :detail, presence: true
    validates :price, presence: true
   #  validates_each :unicode do |record, attr, value|
   #    record.errors.add(attr, 'Debe tener 3 numeros y luego 6 letras') if !(value =~ /^[a-zA-Z]{3}\d{6}$/)
   #  end
    has_many :items
    def self.getScarce
       prods = Product
        .select("products.*, COUNT(items.id) as items_count")
        .joins('LEFT JOIN items ON (products.id = items.product_id)')
        .having('COUNT(items.id) >= 0 AND COUNT(items.id) < 6')
        .group(:id)#.count.select { |k, v| (v > 0) && (v<6) } 
       #prods.map { |key, value|  { "#{Product.find(key).name}": value} }
    end
    
    def self.getInStock
       prods = Product
         .select("products.*, COUNT(items.id) as items_count")
         .joins('LEFT JOIN items ON (products.id = items.product_id)')
         .having('COUNT(items.id) >= 0')
         .group(:id)
      #prods = Product.joins(:items).group(:id).count.select { |k, v| (v > 0)} 
      #prods.map { |key, value|  { "#{Product.find(key).name}": value} }
    end
    
    def self.getAll
      prods = Product
         .select("products.*, COUNT(items.id) as items_count")
         .joins('LEFT JOIN items ON (products.id = items.product_id)')
         .group(:id)
      #prods = Product.joins(:items).group(:id).count
      #prods.map { |key, value|  { "#{Product.find(key).name}": value} } 
    end

    def self.createItems(product, create)
        create.to_i.times {Item.create!(product_id: product, status: 'Disponible', created_at: Time.now.utc, updated_at: Time.now.utc)}
     end
    
end
