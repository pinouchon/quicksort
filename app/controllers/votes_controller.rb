class VotesController < ApplicationController
  def vote
    vote = current_user.votes
    .where('votable_id = ? AND votable_type = ?', params[:votable_id], params[:votable_type])
    .first
    if !vote
      vote = Vote.create(
          votable_id: params[:votable_id],
          votable_type: params[:votable_type],
          value: params[:value],
          user_id: current_user.id)
    end
    vote.value = params[:value]
    vote.save
    @error = nil
    if !vote || !vote.valid?
      @error = vote.errors.full_messages.to_s
    end
    #@votable_id = params[:votable_id]
    #@votable_type = params[:votable_type]
  end
  #def index
  #  @votes = Vote.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @votes }
  #  end
  #end
  #
  #def show
  #  @vote = Vote.find(params[:id])
  #  if request.path != vote_path(@vote)
  #    redirect_to @vote, status: :moved_permanently
  #    return
  #  end
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @vote }
  #  end
  #end
  #
  #def new
  #  @vote = Vote.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @vote }
  #  end
  #end
  #
  #def edit
  #  @vote = Vote.find(params[:id])
  #end
  #
  #def create
  #  @vote = Vote.new(params[:vote])
  #
  #  if @vote.save
  #    #flash[:notice] = 'Vote was successfully created.'
  #  end
  #end
  #
  #def update
  #  @vote = Vote.find(params[:id])
  #
  #  respond_to do |format|
  #    if @vote.update_attributes(params[:vote])
  #      format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @vote.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  #def destroy
  #  @vote = Vote.find(params[:id])
  #  @vote.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to votes_url }
  #    format.json { head :no_content }
  #  end
  #end
end
