class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post

  # GET /comments
  # GET /comments.json
  def index
    print "in"
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    print 'show'
    @comments = Comment.all
  end

  # GET /comments/new
  def new
    print "new"
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    print "edit"
  end

  # POST /comments
  # POST /comments.json
  def create
      @comments = @post.comments
      @comment = @post.comments.create(comment_params)
      @comment.user = current_user
      @comment.post = @post
      if @comment.save
        flash[:notice] = "Comment has been created"
    end
      redirect_to post_path(@post)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
      @comments = @post.comments
      @comment = @post.comments.create(comment_params)
      @comment.user = current_user
      @comment.post = @post
      if @comment.update(comment_params)
        flash[:notice] = "Comment has been updated"
      end
        redirect_to post_comments_path
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    print "dest"
    unless current_user
      flash[:alert] = "Please sign in or sign up first"
      redirect_to new_user_session_path
    else
      @comment.destroy
      flash[:notice] = "Comment has been destroyed"
      redirect_to post_comments_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
