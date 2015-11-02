class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show

  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        @links = Link.top_n
        format.html { redirect_to root_url, notice: 'Link was successfully created.' }
        format.js {}
      else
        @links = Link.top_n
        render_action = request.referer.include?("links") ? :new : root_url
        format.html { render render_action }
        format.js {}
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
    end
  end

  def redirect
    @link = Link.find_by(short_url: params[:short_url])
    raise ActiveRecord::RecordNotFound if @link.nil?
    @link.access_count += 1
    respond_to do |format|
      if @link.update(access_count: @link.access_count)
        @links = Link.top_n
        format.html { redirect_to @link.full_url, status: 301 }
        format.js {}
      else
        @links = Link.top_n
        format.html { render root_url, notice: "Sorry, we had a problem processing your request. Please try again or regenerate another URL." }
        format.js {}
      end
    end
  rescue ActiveRecord::RecordNotFound
    flash_msg = "Oops, we couldn't find that link. Please check the link and try again."
    respond_to do |format|
      format.html {redirect_to root_url, flash: {error: flash_msg}}
      format.js {flash.now[:error] = flash_msg}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:full_url, :access_count)
    end

end
