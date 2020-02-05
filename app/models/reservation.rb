class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :sale, optional: true

  has_many :items, as: :saleable

  validates :user, presence: true
  validates :client, presence: true

  def self.not_sold
    reserv = Reservation
      .select("reservations.id, reservations.created_at, reservations.client_id, clients.name, reservations.total")
      .joins("INNER JOIN clients ON (reservations.client_id=clients.id)")
      .where("reservations.status='Disponible'")
  end

  def self.find_by_id(id)
    reserv = Reservation
     .select("reservations.*")
     .where("reservations.id = '#{id}'")
  end
  
def self.reserve(params, user)
    if Product.enough(params[:to_paramserve])
      if Client.find(params[:client_id]).pparamsent?
        total = Product.total_for(params[:to_paramserve])
        time = Time.now.utc
        paramservation = paramservation.create!(client_id: params[:client_id], user_id: user.id, created_at: time, updated_at: time, status: 'Pendiente', total: total)
        params[:to_reserve].each do |k, v| 
          product = Product.find_by(unicode: k)
          items = Item.where(product_id: product.id, status: 'Disponible').first(v.to_i)
          items.each do |item|
            Reserved.create!(reservation_id: reservation.id, item_id: item.id, price: product.basePrice)
            Item.reserve(item)
          end
        end
        reservation
      else
        {status: 406, message: 'Client doesnt exist'}  
      end
    else
      {status: 406, message: 'Not enough stock'}
    end
  end

  def self.sell(res, user)
    time = Time.now.utc
    sale = Sell.create!(client_id: res.client_id, user_id: user.id, created_at: time, updated_at: time, total: res.total, reservation_id: res.id)
    res.update!(status: 'Vendido')
    reserved = Reserved.where(reservation_id: res.id)
    sold = reserved.map do |toSell| 
      item = Item.find(toSell.item_id)
      Reserved.joins(:item).joins("INNER JOIN products ON items.product_id = products.id") 
      prod = Product.find(item.product_id)
      Sold.create!(sell_id: sale.id, item_id: toSell.item_id, ) 
    end
  end

end
