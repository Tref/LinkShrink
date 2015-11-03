class WelcomeController < ApplicationController

  def index
    @link = Link.new
    @links = Link.top_n
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.insensitive_find_or_init(clean_params)
    
    respond_to do |format|
      if @link.save
        @links = Link.top_n
        format.html { redirect_to :index, notice: 'Link was successfully created.' }
        format.js { flash.now[:notice] = 'Link was successfully created.'}
      else
        format.html { render :index }
        format.js {}
      end
    end
  end

  def redirect
    @link = Link.find_by(short_url: params[:short_url])
    respond_to do |format|
      if @link && @link.update(access_count: @link.access_count + 1)
        @links = Link.top_n
        format.html { redirect_to @link.full_url, status: 301 }
        format.js {}
      else
        format.html { redirect_to root_url, flash: {error: "Oops! we couldn't find that link. Please try again or regenerate another URL."} }
        format.js {}
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def clean_params
      params.require(:link).permit(:full_url, :access_count)
    end

end
