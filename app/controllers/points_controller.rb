class PointsController < ApplicationController
  # GET /points
  # GET /points.json
  def index
    @post = Post.find(params[:post_id])
    puts @post
    @points = @post.points.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @post = Post.find(params[:post_id])
    @point = Point.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @post = Post.find(params[:post_id])
    @point = Point.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @point = Point.find(params[:id])
  end

  # POST /points
  # POST /points.json
  def create
    @post = Post.find(params[:post_id])
    @point = @post.points.new(params[:point])

    respond_to do |format|
      if @point.save
        format.html { redirect_to post_point_path(@post, @point), notice: 'Point was successfully created.' }
        format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /points/1
  # PUT /points/1.json
  def update
    @post = Post.find(params[:post_id])
    @point = @post.points.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to post_point_path(@post, @point), notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end
end
