class SportsController < ApplicationController

  def index
  	# List out all links
    @sport = params[:sport] || 'basketball'
    #@league = params[:league] || 'nba'
    #@teams = espn.teams(@sport, @league)
    @sports = espn.all_team_sports
    @non_team_sports = espn.non_team_sports
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  def show
    @sport = params[:id]
  	@news = espn.sport_news(@sport, nil)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def news

  end

end
