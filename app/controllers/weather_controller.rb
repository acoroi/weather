require 'json'
require 'uri'
require 'net/http'

class WeatherController < ApplicationController
  # Default behavior :)
  def hello
    render json: {
      message: 'Ahh, hello. Was it you who rang the bell of awakening?'
    }
  end

  # Show action
  def cities
    # Let's do some input validation
    if params
      if params[:cities].length == 0 || params[:cities].length > 10
        # Return an informative message to the caller if they don't pass along any cities
        # In a perfect world (and one in which I was more familiar with Ruby already), this
        # validation would be done before it even reached the app level (with something like
        # Joi for Node, perhaps).
        render json: {
          message: 'Please pass along some cities you would like to know about (max 10)!'
        }
      elsif params[:temperatureIsCelcius] == nil
        # Return an informative message to the caller if they don't pass along a temperature
        # format.
        render json: {
          message: 'Please make sure you request either true or false for temperatureIsCelsius.'
        }
      else
        # This execution path is "happy" i.e. we should do this work when we receive cities
        # and a temperature format.

        # Check cache first!
        cacheKey = params.hash
        response = Rails.cache.fetch(:cacheKey) do
          buildResponse(params)
        end

        # Render response to the caller
        render json: response
      end
    end
  end

  # Response constructor
  def buildResponse(params)
    cityObjectArr = []

    cities = params[:cities]
    cities.each do |city|
      # We get the temp of the given city here
      temperature = lookupCityTemp(city, params[:temperatureIsCelcius])

      # Add to arr
      cityObject = {
        'city' => city,
        'temperature' => temperature
      }

      cityObjectArr << cityObject
    end

    # Retrieve hot & cold temperatures
    extremeCities = getExtremeCities(cityObjectArr)

    response = {
      'cities' => cityObjectArr,
      'hottestCity' => extremeCities[1],
      'coldestCity' => extremeCities[0]
    }
  end
  
  # Lookup the city against the OpenWeather API
  def lookupCityTemp(city, temperatureIsCelcius)
    begin
      openweather_base_url = 'https://api.openweathermap.org/data/2.5/weather'
      # Function should take a city and look it up against OpenWeather's getWeatherByCity functionality
      uri = URI(openweather_base_url)

      # Boolean temperatureIsCelius -> if true then use metric, otherwise use imperial
      units = temperatureIsCelcius ? 'metric' : 'imperial'

      # QS params
      params = {
        :q => city,
        :appid => ENV['OPENWEATHER_API_KEY'],
        :units => units
      }

      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      json_response = JSON.parse(res.body)

      # Extract fields from the response that we care about and return
      json_response['main']['temp']
    rescue => e
      puts "Exception trapped #{e}"
    end
  end

  def getExtremeCities(cities)
    temps = cities.sort_by {|city| city['temperature']}

    # First element is coldest, last is hottest
    [temps[0], temps[temps.length - 1]]
  end
end
