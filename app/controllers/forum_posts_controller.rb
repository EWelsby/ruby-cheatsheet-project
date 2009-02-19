class ForumPostsController < ApplicationController
  # GET /forum_posts
  # GET /forum_posts.xml
  def index

      # they are not allowed to index post as they are a child of a thread. so instead redirect to show whatever thread is in the path
      @forum_thread = ForumThread.find(params[:forum_thread_id])      
      redirect_to(@forum_thread)
    
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.xml
  def show
   
    @forum_post = ForumPost.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_post }
    end
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.xml
  def new
    
    @forum_thread = ForumThread.find(params[:forum_thread_id])        
    
    unless logged_in?
      
      flash[:notice] = 'You must be logged in to carry out this command.'
      redirect_to(@forum_thread)   
      
    else    

      @forum_post = ForumPost.new     
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @forum_post }
      end
      
  end
  end

  # GET /forum_posts/1/edit
  def edit
    @forum_thread = ForumThread.find(params[:forum_thread_id])     
    @forum_post = ForumPost.find(params[:id])
  end

  # POST /forum_posts
  # POST /forum_posts.xml
  def create

    @forum_thread = ForumThread.find(params[:forum_thread_id])  
    
    unless logged_in?
      
      flash[:notice] = 'You must be logged in to carry out this command.'
      redirect_to(@forum_thread)   
      
    else    
    
      # Manually set the inaccessible values
      @forum_post = ForumPost.new(params[:forum_post])    
      @forum_post.forum_thread = @forum_thread;  
      @forum_post.user = current_user;
    
      respond_to do |format|
        if @forum_post.save
          flash[:notice] = 'ForumPost was successfully created.'
          format.html { redirect_to(@forum_thread) }
          format.xml  { head :ok }        
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @forum_post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /forum_posts/1
  # PUT /forum_posts/1.xml
  def update
    
    @forum_post = ForumPost.find(params[:id])
    
    if current_user == @forum_post.user    
    
      respond_to do |format|
        if @forum_post.update_attributes(params[:forum_post])
          flash[:notice] = 'ForumPost was successfully updated.'
          format.html { redirect_to(@forum_post) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @forum_post.errors, :status => :unprocessable_entity }
        end
      end
      
    else
    
      flash[:notice] = 'Only the post creator can edit this post.'
      @forum_thread = ForumThread.find(params[:forum_thread_id])        
      redirect_to(@forum_thread)      
      
    end
    
    
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.xml
  def destroy
    @forum_post = ForumPost.find(params[:id])
    if current_user == @forum_post.user        
    
      @forum_post.destroy

      respond_to do |format|
        format.html { redirect_to(forum_posts_url) }
        format.xml  { head :ok }
      end
      
    else
      
      flash[:notice] = 'Only the post creator can delete this post.'
      @forum_thread = ForumThread.find(params[:forum_thread_id])        
      redirect_to(@forum_thread)      
      
    end
  end
end
