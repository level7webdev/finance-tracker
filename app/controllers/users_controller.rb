class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks.order('ticker')
  end

  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks.order('ticker')
  end

  def my_friends
    @tracked_users = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends.any?
        respond_to do |format|
          format.js { render partial: 'users/friends_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No user found"
          format.js { render partial: 'users/friends_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or email to search"
        format.js { render partial: 'users/friends_result' }
      end
    end
  end

end
