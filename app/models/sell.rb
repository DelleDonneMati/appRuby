class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :reservation


	def self.sellsUser(id_user) 
		sells = Sell
			.select("sells.created_at, clients.name, sells.total")
			.joins("LEFT JOIN client ON (sells.client_id = client.id")
			.where("sells.client_id = '#{id}'")
	end

	def self.sellsById(id)
		sells = Sell
			.select("sells.created_at, clients.name, sells.total")
			.joins("LEFT JOIN client ON (sells.client_id = client.id")
			.where("sells.id = '#{id}'")
	end

	def self.sellCreation(sale, user)
		enough = {}
	    # sale[:to_sell].each { |k, v| enough[k] = (Product.where(unicode: k).joins(:items).count) > v.to_i}
	    if enough.all?
      	client = Client.find(sale[:client_id])
  			if client.present?
				total = {}
		        sale[:to_sell].each { |k, v| total[k] = Product.where(unicode: k).select(:basePrice) } 
		        total = total.values.flatten.collect { |p| p.basePrice }  
		        total = total.inject(:+)
		        time = Time.now.utc
				selling = Sell.create!(client_id: client.id, user_id: user.id, created_at: time, updated_at: time, total: total)
		        sale[:to_sell].each do |k, v| 
		          v.to_i.times do
		            product = Product.find_by(unicode: k)
		            item = Item.find_by(product_id: product.id, status: 'Disponible')
		            Sold.create!(sell_id: selling.id, item_id: item.id, price: product.basePrice)
		            item.update!(status: 'Vendido')
		          end
		        end
		        selling
	    	else
        		{status: 406, message: 'No Existe el Cliente'}  
      		end
    	else
      		{status: 406, message: 'No hay suficiente Stock'}
    	end
  end

end
