class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show, :single, :byCountry, :byPost, :all]

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  def single
    city = City.find(params[:id])
    # render json: {
    #   'id' => params[:id],
    #   'title' => e['title'],
    #   'venue' => e['venue']['name'],
    #   'tickets' => e['tickets'][0]['ticket']['quantity_available'].to_s
    # }
    # render text: ''
    render json: city
  end

  def byCountry
    country = Country.friendly.find(params[:id])

    bunch = []
  
    City.all.each { |city|
      if city.country_id == country.id
        bunch << city
      end
    }
    render json: bunch
  end

  def byPost
    post = Post.friendly.find(params[:id])

    bunch = []

    City.all.each do |city|
      if city.country_id = post.country_id #all cities in the same country as post
        #error: post.country_id is nill
        bunch << city
      end
    end
  
    render json: bunch
  end

  def all
    render json: City.all
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to dashboard_index_path, notice: 'City was successfully created.' }
        format.json { render action: 'show', status: :created, location: @city }
      else
        format.html { render action: 'new' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to dashboard_index_path, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :description, :country_id, :map)
    end
end
