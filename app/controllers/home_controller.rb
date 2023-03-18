class HomeController < ApplicationController
  def page
    redirect_to articles_path if logged_in?
  end
end
