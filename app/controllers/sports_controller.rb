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
    @sport = params[:sport]
    @league = params[:league]
    if params[:team]
      @team = espn.team(@sport, @league, params[:id].to_s)
      @news = espn.team_news(@sport, @league, params[:id].to_s)
    else
      @news = espn.sport_news(@sport, @league)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def news

  end

end
