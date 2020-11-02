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

end