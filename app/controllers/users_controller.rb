class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "#{@user.name} created."
  		redirect_to users_path
  	else
  		render 'new'
  	end
  end

  def index
  	@users = User.all
    @userStats = User.stats
    @users = @users.sort_by do |user|
      @userStats[user.id][1]
    end
    @users.reverse!
    @winRate = Hash.new
    @users.each do |user|
      @winRate[user.id] = ((@userStats[user.id][1].to_f /  (@userStats[user.id][1].to_f + @userStats[user.id][0].to_f)) * 100).round(0)
    end
  end

  def show
    @user = User.find(params[:id])
    @victories = User.victories(@user.id)
    @defeats = User.defeats(@user.id)
  end

  def compare
    @users = User.all
    if params[:id1] && params[:id2]
      @user1 = User.find(params[:id1])
      @user2 = User.find(params[:id2])
      @u1matches = User.wins_against(@user1.id, @user2.id)
      @u2matches = User.wins_against(@user2.id, @user1.id)
    else
    end
  end
  
  private

  def user_params
  	params.require(:user).permit(:name)
  end
end
