class OrgtreesController < ApplicationController
  before_filter :authenticate_user!
  # GET /orgtrees
  # GET /orgtrees.json
  def index
    # @orgtrees = Orgtree
    # @orgtrees = Orgtree.order("id ASC").page(params[:page]).per(5)
    @orgtrees = Orgtree.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orgtrees }
    end
  end

  # GET /orgtrees/1
  # GET /orgtrees/1.json
  def show
    @orgtree = Orgtree.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orgtree }
    end
  end

  # GET /orgtrees/new
  # GET /orgtrees/new.json
  def new
    @orgtree = Orgtree.new
    @users = User.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @orgtree }
    end
  end

  # GET /orgtrees/1/edit
  def edit
    @orgtree = Orgtree.find(params[:id])
  end

  # POST /orgtrees
  # POST /orgtrees.json
  def create
    @orgtree = Orgtree.new(params[:orgtree])

    respond_to do |format|
      if @orgtree.save
        format.html { redirect_to @orgtree, notice: 'Membro criado com sucesso.' }
        format.json { render json: @orgtree, status: :created, location: @orgtree }
      else
        format.html { render action: "new" }
        format.json { render json: @orgtree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orgtrees/1
  # PUT /orgtrees/1.json
  def update
    @orgtree = Orgtree.find(params[:id])

    respond_to do |format|
      if @orgtree.update_attributes(params[:orgtree])
        format.html { redirect_to @orgtree, notice: 'Orgtree was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @orgtree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgtrees/1
  # DELETE /orgtrees/1.json
  def destroy
    @orgtree = Orgtree.find(params[:id])
    @orgtree.destroy

    respond_to do |format|
      format.html { redirect_to orgtrees_url }
      format.json { head :no_content }
    end
  end
end
