class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_filter :authenticate_user!
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], per_page: 20).order('created_at DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @new_comment    = Comment.build_from(@post, current_user.id, "")
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
    authorize! :update, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = User.find_by_email("sumanpuri55@gmail.com")
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        PostMailer.post_created(@user, @post.user).deliver

        format.html { redirect_to @post, notice: 'Link submitted' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    authorize! :update, @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Link updated' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize! :destroy, @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Link deleted' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post.upvote_from current_user
    redirect_to :back
  end

  def downvote
    @post.downvote_from current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :tag_list)
    end
end
