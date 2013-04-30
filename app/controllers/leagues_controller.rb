class LeaguesController < ApplicationController

  def show
    @sport = params[:sport_id]
    @league = params[:id]
    @teams = espn.teams(@sport, @league)
    @sports = espn.all_team_sports
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  def news
  	puts 'im in the news'
    @sport = params[:sport_id]
    @league = params[:id]
  	#@team = espn.team(@sport, @league, params[:id].to_s)
    @news = espn.sport_news(@sport, @league)
    puts @news
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
end
