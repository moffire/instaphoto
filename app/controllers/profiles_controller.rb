class ProfilesController < ApplicationController
  before_action :set_user


  def show
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to photos_path if @user.nil?
  end

end

