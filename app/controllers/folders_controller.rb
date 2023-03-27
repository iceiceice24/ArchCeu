class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :folder_file]

  def index
    @folders = Folder.roots
  end

  def show
    @subfolders = @folder.subfolders
  end

  def new
    @folder = Folder.new
    @parent_folder = Folder.find_by(id: params[:parent_folder_id])
  end
  

  def edit
  end

  def create
    @folder = Folder.new(folder_params)
  
    if @folder.parent_folder_id.present?
      parent_folder = Folder.find_by(id: @folder.parent_folder_id)
  
      if parent_folder
        @folder.parent_id = parent_folder.id
      else
        flash[:alert] = "Invalid parent folder selected"
        render :new
        return
      end
    end
  
    if @folder.save
      redirect_to @folder, notice: 'Folder was successfully created.'
    else
      render :new
    end
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
    @folder.files.purge
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
      params.require(:folder).permit(:name, :parent_folder_id,  files: [])
    end
end