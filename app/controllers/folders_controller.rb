class FoldersController < ApplicationController
  before_filter :authenticate_user!
  # GET /folders
  # GET /folders.json
  def index
    if current_user.roles.first.name == 'admin'
      @folders = Folder.all
    else
      @folders = Folder.find_all_by_role_id(current_user.roles.first.id)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
  end

  def explorer_view
    @folders = Folder.all
  end

  def manager_view
    if current_user.roles.first.name == 'admin'
      @folders = Folder.order("ID DESC").page(params[:page]).per(10)
      # @uploaders = Uploader.all
    else
      @folders = Folder.find_all_by_role_id(current_user.roles.first.id).order("ID DESC").page(params[:page]).per(10)
      # @uploaders = Uploader.find_all_by_role_id(current_user.roles.first.id)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = Folder.find(params[:id])
    @uploaders = Uploader.find_all_by_folder_id(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folder }
    end
  end

  # GET /folders/new
  # GET /folders/new.json
  def new
    @folder = Folder.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folder }
    end
  end

  def new_folder
    @folder = Folder.new(params[:folder])
    @folder.author    = current_user.name
    unless current_user.roles.first.name == 'admin'
      @folder.role_id = current_user.roles.first.id
    end
    respond_to do |format|
      if @folder.save
        format.html { redirect_to manager_path, notice: 'Pasta "'+@folder.name+ '" criada com sucesso.' }
      else
        format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])

  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(params[:folder])
    @folder.author = current_user.name
    unless current_user.roles.first.name == 'admin'
      @folder.role_id = current_user.roles.first.id
    end
    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'Pasta "'+@folder.name+ '" criada com sucesso.' }
        format.json { render json: @folder, status: :created, location: @folder }
      else
        format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.json
  def update
    @folder = Folder.find(params[:id])
    @folder.author    = current_user.name
    unless current_user.roles.first.name == 'admin'
      @folder.role_id = current_user.roles.first.id
    end
    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to @folder, notice: 'Pasta atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to manager_path }
      format.json { head :no_content }
    end
  end

  # def download_all
  #   # code here
  # end
end
