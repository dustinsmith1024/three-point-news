class TeamsController < ApplicationController

  def show
    @sport = params[:sport]
    @league = params[:league]
    @team = espn.team(@sport, @league, params[:id].to_s)
    @news = espn.team_news(@sport, @league, params[:id].to_s)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

end
