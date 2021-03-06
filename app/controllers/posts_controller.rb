class PostsController < ApplicationController
  before_filter :authenticate_user!
  layout 'design'

  # GET /posts
  # GET /posts.json
  def index
    @sites = current_user.sites
    @posts = current_user.posts.filter_post_type(params[:post_type]).filter_site(params[:site]).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @sites = current_user.sites
    @post = current_user.posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @sites = current_user.sites
    @post = Post.new
    @post_type = params[:post_type]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @sites = current_user.sites
    @post = current_user.posts.find(params[:id])
    @post_type = @post.post_type
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Site.find(params[:post][:site_id]).posts.build(params[:post])

    respond_to do |format|
      if @post.save
        if (params[:send_email] == "1")
          PostMailer.new_document(@post).deliver
        end
        format.html { redirect_to sites_url, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to sites_url, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_url }
      format.json { head :no_content }
    end
  end
end
