class FoldersController < ApplicationController
  before_action :set_user
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
 
  def index
    @folders = Folder.roots
    @folder = Folder.new
  end

  def home
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
    @user = User.find(params[:user_id])
    @folder = @user.folders.build(folder_params)
  
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
      redirect_to @folder, notice: "Folder was successfully created."
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
    if params[:q].blank?
      redirect_to folders_path and return
    else
      query = params[:q]
      @results = Folder.all.where('lower(name) LIKE ?', "%#{query.downcase}%")
      
    end
  end

  private

    def set_user
       @user = current_user
    end

    def set_folder
      @folder = Folder.find(params[:id])
    end

    def folder_params
      params.require(:folder).permit(:name, :parent_folder_id, files: [])
    end

    def initialize_folder
      @folder = Folder.new
    end
end