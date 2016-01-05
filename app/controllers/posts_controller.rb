class PostsController < ApplicationController

  load_and_authorize_resource :except => [:user, :update_status, :add_rating]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :update_status, :add_rating]
  #skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, :only => [:user]


  # GET /posts
  # GET /posts.json
  def index

    if not params[:from].present?
      from = Date.yesterday
      to = Date.today
    else
      from = params[:from]
      to = params[:to]
    end

    if params[:topic_id].present?
		  @topic = Topic.find(params[:topic_id])
		  @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
      @post = @topic.posts.new
    else
      @posts = (Post.created_after(from).created_before(to)).eager_load(:topic, :user).paginate(page: params[:page], per_page: 10)
    end
    @tags =Tag.all

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
	  @tags = @posts.tags
  end

  def update_status
      current_user.posts<<(@posts)
  end

  # GET /posts/new
  def new
	  @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.new
    @tags =Tag.all
  end

  # GET /posts/1/edit
  def edit
    @tags = @posts.tags
  end

  def add_rating
    @posts.ratings.create(:star => params[:rate])
    respond_to do |format|
      format.html { redirect_to post_path(@posts), notice: 'Rating was successfully updated.' }
    end
  end

  def user
    authenticate_or_request_with_http_basic do |username, password|
      user = User.find_by_email(username)
      if user.valid_password?(password)
        render json: user
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

  # POST /posts
  # POST /posts.json
  def create

	  @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.create(post_params)

    respond_to do |format|
      @posts.user_id = current_user.id
      if @posts.save
        format.html { redirect_to topic_posts_path(@topic), notice: 'Post was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @posts }

      else
        format.html { render :new }
        format.js
        format.json { render json: @posts.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
	  @tags = @posts.tags
    respond_to do |format|

      if @posts.update(post_params)
        format.html { redirect_to post_path(@posts), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @posts }

      else
        format.html { render :edit }
        format.json { render json: @posts.errors, status: :unprocessable_entity }

      end
    end
  end


  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @posts.destroy
    respond_to do |format|
      format.html { redirect_to topic_posts_url(@posts.topic_id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
     @posts = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image, :name, :message, :topic_id, {tag_ids:[]}, :rate, :user_id, :from, :to)
    end

  protected

    def json_request?
      request.format.json?
    end
end
