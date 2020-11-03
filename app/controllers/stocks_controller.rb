class StocksController < ApplicationController

  def search
    if params[:stock].present?
      stock = params[:stock].upcase
      @stock = Stock.new_lookup(stock)
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/stocks_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/stocks_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/stocks_result' }
      end
    end
  end

  def update
    stock = Stock.find(params[:id])
    stock_update = Stock.new_lookup(stock.ticker)
    stock.last_price = stock_update.last_price
    stock.save
    redirect_to my_portfolio_path
  end

end