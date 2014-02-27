class LinksController < ApplicationController
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  def show
    @link = Link.find(params[:id])
    if request.path != link_path(@link)
      redirect_to @link, status: :moved_permanently
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(params[:link])
    @link.user_id = current_user.id

    @topic = Topic.find(params['link']['topic_id'].to_i)
    if (!@topic)
      @link.errors.add('Cannot find related topic')
    end

    if @link.save
      #flash[:notice] = 'Link was successfully created.'
    end

    #respond_to do |format|
    #  if @link.save
    #    flash[:notice] = 'Link was successfully created.'
    #    format.html { redirect_to @link, notice: 'Link was successfully created.' }
    #    format.js { render json: @link, status: :created, location: @link }
    #  else
    #    format.html { render action: "new" }
    #    format.js { render json: @link.errors }
    #  end
    #end
  end

  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end
end
