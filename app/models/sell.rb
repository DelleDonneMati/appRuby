class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :reservation

  def self.allSellsWithUser(reservation)
    if params[:authentication].present?
      token = params[:authentication]
      user = Token.authenticate(token)
      if user.present?
        sales = Sell.where(user_id: user.id).select(:created_at, :total, :client_id)
        sales = sales.map { |sale| {"Client": "#{Client.find(sale.client_id).name}", "Date": "#{sale.created_at}", "Total": "#{sale.total}"}} 
        render json: sales
      else
        render status: 404
      end
  end

  def  self.sellUser
    if params[:authentication].present?
      token = params[:authentication]
      user = Token.authenticate(token)
      if user.present?
        sales = Sell.find(params[:id])
        sales = {"Client": "#{Client.find(sales.client_id).name}", "Date": "#{sales.created_at}", "Total": "#{sales.total}"}
        if params[:items].present?
          sales[:Items] = Sold.joins(:sell, :item).where("solds.sell_id= 1").select("items.*")
        end
        render json: sales
      else
        render status: 404
      end
    end
  end

  def self.sell
    if params[:authentication].present?
      token = params[:authentication]
      user = Token.authenticate(token)
      if user.present?
        Sell.sell(params, user)
      else
        render status: 404
      end
    else
      render status: 404
    end
  end

end
