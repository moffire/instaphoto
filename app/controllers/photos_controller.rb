class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.all.order('created_at DESC').paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
    @photo = current_user.photos.build
  end

  def edit
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: 'Photo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo was successfully destroyed.'
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:description, :image)
  end

  #check if the User is owner of current photo
  def owner
    @photo = current_user.photos.find_by(id: params[:id])
    redirect_to photos_path, notice: "You have no rights to change this photo" if @photo.nil?
  end
end
