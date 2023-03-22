class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def index
    @folders = Folder.roots
  end

  def show
    @subfolders = @folder.subfolders
  end

  def new
    @folder = Folder.new
    if params[:parent_id].present?
      @folder.parent_folder_id = params[:parent_id]
    end
  end

  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      redirect_to @folder, notice: 'Folder was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @folder.update(folder_params)
      redirect_to @folder, notice: 'Folder was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @folder.destroy
    redirect_to folders_url, notice: 'Folder was successfully destroyed.'
  end

  def search
    query = params[:q]
    @folder = Folder.where('name LIKE ?', "%#{query}%").first

    if @folder
      redirect_to @folder
    else
      flash.now[:alert] = "Folder not found."
      render :index
    end
  end

  private
    def set_folder
      @folder = Folder.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name, :parent_folder_id, files: [])
    end
end
