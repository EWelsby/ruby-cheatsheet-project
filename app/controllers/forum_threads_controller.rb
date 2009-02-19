class ForumThreadsController < ApplicationController
  # GET /forum_threads
  # GET /forum_threads.xml
  def index
    @forum_threads = ForumThread.find(:all)
    @forum_threads = @forum_threads.paginate :per_page => 10, :page => params[:page], :order => 'id'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_threads }
    end
  end

  # GET /forum_threads/1
  # GET /forum_threads/1.xml
  def show

    #fetch the forum thread based on the url
    @forum_thread = ForumThread.find(params[:id])

    #fetch an array of all the forum posts using the pagination plugin
    @forum_posts = @forum_thread.forum_posts.paginate :per_page => 10, :page => params[:page], :order => 'id'

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_thread }
    end
  end

  # GET /forum_threads/new
  # GET /forum_threads/new.xml
  def new

    unless logged_in?

      flash[:notice] = 'You must be logged in to carry out this command.'
      redirect_to(forum_threads_path)

    else
      @forum_thread = ForumThread.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @forum_thread }
      end
    end
  end

  # GET /forum_threads/1/edit
  def edit
    @forum_thread = ForumThread.find(params[:id])
  end

  # POST /forum_threads
  # POST /forum_threads.xml
  def create

    unless logged_in?

      flash[:notice] = 'You must be logged in to carry out this command.'
      redirect_to(forum_threads_path)

    else

      @forum_thread = ForumThread.new(params[:forum_thread])
      @forum_thread.user = current_user;

      respond_to do |format|
        if @forum_thread.save
          flash[:notice] = 'ForumThread was successfully created.'
          format.html { redirect_to(@forum_thread) }
          format.xml  { render :xml => @forum_thread, :status => :created, :location => @forum_thread }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @forum_thread.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /forum_threads/1
  # PUT /forum_threads/1.xml
  def update
    @forum_thread = ForumThread.find(params[:id])

    if current_user == @forum_thread.user

      respond_to do |format|
        if @forum_thread.update_attributes(params[:forum_thread])
          flash[:notice] = 'ForumThread was successfully updated.'
          format.html { redirect_to(@forum_thread) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @forum_thread.errors, :status => :unprocessable_entity }
        end
      end

    else

      flash[:notice] = 'Only the thread creator can edit this thread.'
      redirect_to(@forum_thread)

    end
  end

  # DELETE /forum_threads/1
  # DELETE /forum_threads/1.xml
  def destroy
    @forum_thread = ForumThread.find(params[:id])

    if current_user == @forum_thread.user

      @forum_thread.destroy

      respond_to do |format|
        format.html { redirect_to(forum_threads_url) }
        format.xml  { head :ok }
      end

    else

      flash[:notice] = 'Only the thread creator can delete this thread.'
      redirect_to(@forum_thread)

    end
  end

end
