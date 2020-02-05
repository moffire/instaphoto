class ProfilesController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, only: [:subscribe, :unsubscribe]


  def show
  end

  def subscribe
    if current_user.id != @user.id
      if current_user.subscriptions.exists?(friend_id: @user.id)
        redirect_to profile_path(@user), notice: "You have already subscribed to #{@user.email}"
      else
        subscription = current_user.subscriptions.build
        subscription.friend_id = @user.id
        subscription.save
        if subscription.save
          redirect_to profile_path(@user), notice: "You have successfully subscribed to #{@user.email}"
        end
      end
    else
      redirect_to root_path
    end
  end

  def unsubscribe
    if current_user.id != @user.id
      if !current_user.subscriptions.exists?(friend_id: @user.id)
        redirect_to profile_path(@user), notice: "You don't have subscription to #{@user.email}"
      else
        subscription = current_user.subscriptions.find_by(friend_id: @user.id)
        subscription.destroy
        redirect_to profile_path(@user), notice: "You have successfully unsubscribed from #{@user.email}"
      end
    else
      redirect_to root_path
    end
  end


  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to photos_path if @user.nil?
  end

end

