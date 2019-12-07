class Product < ApplicationRecord
has_many :items

    def self.getProdStock(prod)
        @connection = ActiveRecord::Base.connection
  		result = @connection.exec_query("SELECT COUNT(*) FROM products p INNER JOIN items i ON (p.id = i.product_id) WHERE i.status='Disponible'")
        return result[0]['count']
	end

    def self.getScarce(prods)
        query = {}
        prods.map { |prod| query[prod.name] = self.getProdStock(prod)}
        result = query.select { |p| ((query[p] > 0) && (query[p] < 6))}
        return result
    end

    def self.getInStock(prods)
        query = {}
        prods.map { |prod| query[prod.name] = self.getProdStock(prod)}
        result = query.select { |p| query[p] > 0}
        return result
    end

    def self.getAll(prods)
        query = {}
        prods.map { |prod| query[prod.name] = self.getProdStock(prod)}
        return query
    end

    def self.prodWithCod(code)
        @connection = ActiveRecord::Base.connection
        result = @connection.exec_query("SELECT * FROM products p WHERE p.unicode = '#{code}'")
        return result
    end

    def self.prodCodeItems(code)
        @connection = ActiveRecord::Base.connection
        result = @connection.exec_query("SELECT * FROM products p INNER JOIN items i ON (p.id=i.product_id) WHERE p.unicode = '#{code}'")
        return result
    end
      
end
