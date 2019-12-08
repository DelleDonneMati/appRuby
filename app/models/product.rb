class Product < ApplicationRecord

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
