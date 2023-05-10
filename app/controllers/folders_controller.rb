class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: [:docs, :show, :edit, :update, :destroy]
  before_action :set_user

  def index
    if current_user.admin?
      @folders = Folder.all.roots
    else
      @folders = current_user.folders.roots
      @share = Folder.all
      @folder = Folder.new      
    end

    
  end

  def home
    @folders = current_user.folders.roots
  end 

  def file
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end  

  def show
    @subfolders = @folder.subfolders
    sort_direction = params[:sort] == 'asc' ? :asc : :desc
    @folderFiles = @folder.files.order(created_at: sort_direction)
    @folderName = @folder.name
    @parent = @folder.parent_id
    
      if @parent.present? 
        flag = true
        current_id = @parent      
        @id_arr = Array.new()
        @id_arr.append(@folder)
        while flag do
          result = Folder.find_by(id: current_id)
            if result.parent_id.present?
              @id_arr.append(result)           
              current_id = result.parent_id             
            else
              @first_parent_id = result
              flag = false
            end
        end       
      else      
        @first_parent_id = @folder
      end
  end

  def new
    @folder = current_user.folders.build
    @parent_folder = Folder.find_by(id: params[:parent_folder_id])
  end

  def edit
  end

  def create
    @folder = current_user.folders.build(folder_params)
  
    if @folder.parent_folder_id.present?
      parent_folder = current_user.folders.find_by(id: @folder.parent_folder_id)
  
      if parent_folder
        @folder.parent_id = parent_folder.id
      else
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
      query = params[:q].downcase
      @results = current_user.folders.where('lower(name) LIKE ?', "%#{query}%")
      @file_results = current_user.folders.joins(files_attachments: :blob).where('lower(active_storage_blobs.filename) LIKE ?', "%#{query}%")
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
      params.require(:folder).permit(:name,:department, :parent_folder_id, files: [])
    end

    def initialize_folder
      @folder = Folder.new
    end
end
