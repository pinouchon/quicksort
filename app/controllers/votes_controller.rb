class VotesController < ApplicationController
  #skip_before_filter :verify_authenticity_token
  #before_filter :authenticate_user!

  def vote
    #binding.pry
    if !['-1', '-2', '0', '1', '2'].include?(params[:value])
      render json: {success: false,
                    error_message: 'Incorrect value. Must be -1, -2, 0, 1 or 2',
                    total: 0,
                    value: 0}
      return
    end
    #binding.pry
    vote = current_user.votes_cast
    .where('votable_id = ? AND votable_type = ?', params[:votable_id], params[:votable_type])
    .first
    if !vote
      vote = Vote.new(
          votable_id: params[:votable_id],
          votable_type: params[:votable_type],
          value: params[:value],
          user_id: current_user.id)
    end
    vote.value = params[:value]

    if current_user.id == vote.votable.user.id
      render json: {success: false,
                    error_message: 'You cannot vote on your own post.',
                    total: vote.votable.total_votes,
                    value: 0}
      return
    end
    vote.save

    #update reputation
    current_user.recalculate_reputation # voter
    receiver = User.find(vote.votable.user)
    receiver.recalculate_reputation if receiver

    @error = nil
    if !vote || !vote.valid?
      render json: {success: false,
                    error_message: vote.errors.full_messages.to_s,
                    total: vote.votable.total_votes,
                    value: 0}
      return
    end
    #@votable_id = params[:votable_id]
    #@votable_type = params[:votable_type]
    render json: {success: true, value: vote.value, total: vote.votable.total_votes}
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
