class Product < ApplicationRecord
    validates :unicode, presence: true, uniqueness: true
    validates :descrip, presence: true, length: { maximum: 200 }
    validates :detail, presence: true
    validates :price, presence: true
   validates_each :unicode do |record, attr, value|
     record.errors.add(attr, 'Debe tener 3 numeros y luego 6 letras') if !(value =~ /^[a-zA-Z]{3}\d{6}$/)
   end
    has_many :items
    def self.getScarce
       prods = Product.joins(:items).group(:id).count.select { |k, v| (v > 0) && (v<6) } 
       prods.map { |key, value|  { "#{Product.find(key).name}": value} }
    end
    
    def self.getInStock
       prods = Product.joins(:items).group(:id).count.select { |k, v| (v > 0)} 
       prods.map { |key, value|  { "#{Product.find(key).name}": value} }
    end
    
    def self.getAll
       prods = Product.joins(:items).group(:id).count
       prods.map { |key, value|  { "#{Product.find(key).name}": value} } 
    end

    def self.createItems(product, create)
        create.to_i.times {Item.create!(product_id: product, status: 'Disponible', created_at: Time.now.utc, updated_at: Time.now.utc)}
     end
    
end
