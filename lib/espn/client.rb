# coding: UTF-8
require "httparty"

module Espn
  class Client
    #include EspnRb::Utilities
    include HTTParty
    base_uri 'api.espn.com/v1/'
    format :json

    def initialize(options={})
      @api_key = options[:api_key]
      #@base_uri = 'http://api.espn.com/v1/'
    end
    # Returns an EspnRb::Headline object.
    #
    # @param [Hash] options the options to create the Headline object.
    # @option options [String] :api_key Your ESPN developer api key.
    # @return [EspnRb::Headline] entry point to Espn Headline API.
    def append_key(path)
      path + "apikey=#{@api_key}"
    end

    def by_date(date)
      # add this to filter by a date
      "&dates=20130313"
    end

    def team_news(team_id)
      #http://api.espn.com/v1/sports/basketball/nba/teams/2/news?apikey=8hu4nra8956f8kymyq955j33&limit=3
      path = append_key("sports/basketball/nba/teams/#{team_id}/news?insider=no&")
      response = self.class.get(path, {})
      #get(@base_uri + path + '?' + @api_key)
      #news['headlines'][0]['images']
      #news['headlines'][0].keys
      news = response['headlines']
      news.map {|item| NewsItem.create(item)}
    end

    def teams(league_slug)
      #http://api.espn.com/v1/sports/basketball/nba/teams?apikey=8hu4nra8956f8kymyq955j33
      path = append_key("sports/basketball/#{league_slug}/teams?")
      response = self.class.get(path, {})
      teams = response['sports'][0]['leagues'][0]['teams']
      teams.map {|item| Team.create(item)}
    end

    def team(league_slug, team_id)
      #http://api.espn.com/v1/sports/basketball/nba/teams?apikey=8hu4nra8956f8kymyq955j33
      path = append_key("sports/basketball/#{league_slug}/teams/#{team_id}?")
      response = self.class.get(path, {})
      team = response['sports'][0]['leagues'][0]['teams'][0]
      Team.create(team)
    end

    def images
      # Since they only send the smallest image we could hack in the big ones
      # by parsing the URI

      # Or we could have someone test out the images and download them to our server
      # Then serve the images straight of our netowrk....which might suck
    end
  end

  class NewsItem < Struct.new(:headline, :keywords, :lastModified, :audio, :premium, :mobileStory, :links, :type, :related, :id, :story, :title, :linkText, :byline, :source, :description, :images, :categories, :published, :video)

    def self.create(news_hash)

      self.new(news_hash['headline'],
               news_hash['keywords'],
               news_hash['lastModified'],
               news_hash['audio'],
               news_hash['premium'],
               news_hash['mobileStory'],
               news_hash['links'],
               news_hash['type'],
               news_hash['related'],
               news_hash['id'],
               news_hash['story'],
               news_hash['title'],
               news_hash['linkText'],
               news_hash['byline'],
               news_hash['source'],
               news_hash['description'],
               news_hash['images'],
               news_hash['categories'],
               news_hash['published'],
               news_hash['video'])
    end
  end

  class Team < Struct.new(:id, :location, :name, :abbreviation, :color, :links)

    def self.create(team_hash)

      self.new(team_hash['id'],
               team_hash['location'],
               team_hash['name'],
               team_hash['abbreviation'],
               team_hash['color'],
               team_hash['links'])
    end
  end

end

# #<struct Espn::NewsItem
#   headline=
#    "Gerald Henderson, Bobcats halt 10-game losing streak, beat Celtics",
#   keywords=[],
#   lastModified="2013-03-13T03:16:26Z",
#   audio=[],
#   premium=false,
#   mobileStory="",
#   links=
#    {"api"=>
#      {"news"=>{"href"=>"http://api.espn.com/v1/sports/news/9045696"},
#       "events"=>
#        {"href"=>
#          "http://api.espn.com/v1/sports/basketball/nba/events/400278668"}},
#     "web"=>
#      {"href"=>
#        "http://scores.espn.go.com/nba/recap?gameId=400278668&ex_cid=espnapi_public"},
#     "mobile"=>
#      {"href"=>
#        "http://scores.espn.go.com/nba/gamecast?gameId=400278668&version=mobile&ex_cid=espnapi_public"}},
#   type="Recap",
#   related=[],
#   id=9045696,
#   story="",
#   title=nil,
#   linkText="Bobcats halt 10-game skid, beat Celtics",
#   byline=nil,
#   source="Associated Press",
#   description="Bobcats 100, Celtics 74",
#   images=
#    [{"height"=>324,
#      "alt"=>"",
#      "width"=>576,
#      "name"=>"Bobcats Make Easy Work Of Celtics",
#      "caption"=>
#       "With Paul Pierce taking the night off, the Bobcats are able to snap a 10-game slide with 100-74 win over the Celtics.",
#      "type"=>"video",
#      "credit"=>"Copyright 2013 ESPN Inc",
#      "url"=>
#       "http://a.espncdn.com/media/motion/2013/0312/dm_130312_Celtics_Bobcats/dm_130312_Celtics_Bobcats.jpg"}],
#   categories=
#    [{"description"=>"Charlotte Bobcats",
#      "type"=>"team",
#      "sportId"=>46,
#      "teamId"=>30,
#      "team"=>
#       {"id"=>30,
#        "description"=>"Charlotte Bobcats",
#        "links"=>
#         {"api"=>
#           {"teams"=>
#             {"href"=>"http://api.espn.com/v1/sports/basketball/nba/teams/30"}},
#          "web"=>
#           {"teams"=>
#             {"href"=>
#               "http://espn.go.com/nba/team/_/name/cha/charlotte-bobcats?ex_cid=espnapi_public"}},
#          "mobile"=>
#           {"teams"=>
#             {"href"=>
#               "http://m.espn.go.com/nba/clubhouse?teamId=30&ex_cid=espnapi_public"}}}}},
#     {"description"=>"Boston Celtics",
#      "type"=>"team",
#      "sportId"=>46,
#      "teamId"=>2,
#      "team"=>
#       {"id"=>2,
#        "description"=>"Boston Celtics",
#        "links"=>
#         {"api"=>
#           {"teams"=>
#             {"href"=>"http://api.espn.com/v1/sports/basketball/nba/teams/2"}},
#          "web"=>
#           {"teams"=>
#             {"href"=>
#               "http://espn.go.com/nba/team/_/name/bos/boston-celtics?ex_cid=espnapi_public"}},
#          "mobile"=>
#           {"teams"=>
#             {"href"=>
#               "http://m.espn.go.com/nba/clubhouse?teamId=2&ex_cid=espnapi_public"}}}}},
#     {"description"=>"NBA",
#      "type"=>"league",
#      "sportId"=>46,
#      "leagueId"=>46,
#      "league"=>
#       {"id"=>46,
#        "description"=>"NBA",
#        "links"=>
#         {"api"=>
#           {"leagues"=>
#             {"href"=>"http://api.espn.com/v1/sports/basketball/nba"}},
#          "web"=>
#           {"leagues"=>
#             {"href"=>"http://espn.go.com/nba/?ex_cid=espnapi_public"}},
#          "mobile"=>
#           {"leagues"=>
#             {"href"=>"http://m.espn.go.com/nba/?ex_cid=espnapi_public"}}}}}],
#   published="2013-03-13T01:34:43Z",
#   video=
#    [{"id"=>9045789,
#      "title"=>"Bobcats Make Easy Work Of Celtics",
#      "thumbnail"=>
#       "http://a.espncdn.com/media/motion/2013/0312/dm_130312_Celtics_Bobcats/dm_130312_Celtics_Bobcats.jpg",
#      "description"=>
#       "With Paul Pierce taking the night off, the Bobcats are able to snap a 10-game slide with 100-74 win over the Celtics.",
#      "links"=>
#       {"web"=>
#         {"href"=>
#           "http://espn.go.com/video/clip?id=9045789&ex_cid=espnapi_public"}}}]>,