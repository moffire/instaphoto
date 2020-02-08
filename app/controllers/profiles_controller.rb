class ProfilesController < ApplicationController
  before_action :set_user, except: [:my_photos, :subscribes_list, :friends_photos]
  before_action :authenticate_user!, only: [:subscribe, :unsubscribe]


  def show
  end

  def subscribe
    if current_user.id != @user.id
      if current_user.subscriptions.exists?(friend_id: @user.id)
        redirect_to profile_path(@user), notice: "You have already subscribed to #{@user.name}"
      else
        subscription = current_user.subscriptions.build
        subscription.friend_id = @user.id
        subscription.save
        if subscription.save
          redirect_to profile_path(@user), notice: "You have successfully subscribed to #{@user.name}"
        end
      end
    else
      redirect_to root_path
    end
  end

  def unsubscribe
    if current_user.id != @user.id
      if !current_user.subscriptions.exists?(friend_id: @user.id)
        redirect_to profile_path(@user), notice: "You don't have subscription to #{@user.name}"
      else
        subscription = current_user.subscriptions.find_by(friend_id: @user.id)
        subscription.destroy
        redirect_back fallback_location: root_path, notice: "You have been successfully unsubscribed from #{@user.name}"
      end
    else
      redirect_to root_path
    end
  end

  def my_photos
    @photos = current_user.photos.order('created_at DESC')
  end

  def subscribes_list
    @friends = User.where(id: current_user.subscriptions.pluck(:friend_id))
  end

  def friends_photos
    @photos = Photo.where(user_id: current_user.subscriptions.pluck(:friend_id)).order('created_at DESC')
  end


  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to photos_path if @user.nil?
  end

end

