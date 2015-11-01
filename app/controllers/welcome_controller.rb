class WelcomeController < ApplicationController

  def index
    @link = Link.new
    @links = Link.top_n
  end

end
