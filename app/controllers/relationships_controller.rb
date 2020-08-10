class RelationshipsController < ApplicationController

  before_action :set_user

  def create
    following = current_user.follow(@user)
    #if following.save
      #redirect_to @user
    #else
      redirect_back(fallback_location: root_path)
    #end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def followings
    @user =User.find(params[:id])
    @users =@user.followings.page(params[:page]).per(5)
    render 'followings'
  end

  def followers
    @user =User.find(params[:id])
    @users =@user.followers.page(params[:page]).per(5)
    render 'followers'
  end

  private
  def set_user
    @user = User.find(params[:follow_id])
  end

end
