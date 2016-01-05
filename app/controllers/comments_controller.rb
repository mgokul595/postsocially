class CommentsController < ApplicationController
  load_and_authorize_resource :except => [:rate, :add_rate]
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :rate, :add_rate]

  # GET /comments
  # GET /comments.json
  def index
	  @posts = Post.find(params[:post_id])
    @comment = @posts.comments.eager_load(:user)

  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
	  @posts = Post.find(params[:post_id])
    @comment = @posts.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  def rate
    @ratings = @comment.user_comment_ratings
  end

  def add_rate
    @comment_rating = UserCommentRating.create(star: params[:rate])
    current_user.user_comment_ratings<<@comment_rating
    @comment.user_comment_ratings<<@comment_rating
    respond_to do |format|
     format.html {redirect_to comment_rate_path(@comment)}
    end
  end

  # POST /comments
  # POST /comments.json
  def create
	  @posts = Post.find(params[:post_id])
    @comment = @posts.comments.build(comment_params)

    respond_to do |format|
      @comment.user_id = current_user.id
      if @comment.save
        format.html { redirect_to post_url(@comment.post_id), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
	@comment = Comment.find(params[:id])
    respond_to do |format|

      if @comment.update(comment_params)
        format.html { redirect_to post_url(@comment.post_id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url(@comment.post_id), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :post_id, :user_id, :rate)
    end
end
