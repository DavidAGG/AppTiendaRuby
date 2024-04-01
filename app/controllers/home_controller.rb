class HomeController < ApplicationController
  skip_before_action :protect_pages, only: [:index]
  def index
   
  end
end
 