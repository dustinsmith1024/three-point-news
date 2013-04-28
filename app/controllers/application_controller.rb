class ApplicationController < ActionController::Base
  protect_from_forgery

  def espn
    Dspn::Client.new({api_key: '8hu4nra8956f8kymyq955j33'})
  end
end
