# Weather via Rails

This document assumes that you have Ruby installed on your machine, along with a Rails development environment. Please refer to Ruby's provided documentation for installing Ruby itself. As far as Rails goes, there are a number of helpful writeups online to assist you with your installation - check these out!
* [Monterey Installation](https://gorails.com/setup/osx/12-monterey)
* [General Mac Installation](https://mac.install.guide/rubyonrails/index.html)
* [Windows/Mac Installation](https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm)

## Before you Begin
Make sure you have an OpenWeather API key as well. Instructions for retrieval can be found on the [OpenWeather API Site](https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm). You will need it to look up weather details by city.

## Setup
Provided you have Ruby and Rails (and an OpenWeather API key), you can proceed with running the service locally.

You should first ensure that the environment variable ```OPENWEATHER_API_KEY``` is set with the value of your key. If not, the app will fail to start as it requires that API key to be present (and valid from the perspective of OpenWeather) in order to execute requests.

You can set the key like so:
```export OPENWEATHER_API_KEY=<your key here>```

Once you have cloned the repo and entered the folder, install dependencies by running ```bundle install```. You should see an output like so:
```
Bundle complete! 6 Gemfile dependencies, 54 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

This indicates that your dependencies have installed successfully.

Start the server by running ```rails server```. You can now navigate to ```localhost:3000``` in your API platform of choice (I use Postman) and make some calls!

## API
This service accepts a couple of RESTful calls regarding weather. Details are below.

#### URL

- ```localhost:3000``` (i.e. baseURL)

#### Supported methods

- `GET` | `POST`

### Sample Calls

#### ```GET``` Hello!
This request allows the caller to make sure the app is alive and to say hello!
##### Request
```js
GET {baseURL}/
```
##### Response (200)
```json
{
    "message": "Ahh, hello. Was it you who rang the bell of awakening?"
}
```

#### ```POST``` Weather details
This request allows the caller to pass in a payload that informs them about the temperature (C or F, caller's choice) in various cities around the world. The caller must specify at least one city and no more than 10.
##### Request
```js
POST {baseURL}/weather
```
```json
{
    "cities": [
        "Toronto",
        "Los Angeles",
        "London",
        "Philadelphia",
        "Portland"
    ],
    "temperatureIsCelcius": true
}
```
##### Response (200)
```json
{
    "cities": [
        {
            "city": "Toronto",
            "temperature": 13.58
        },
        {
            "city": "Los Angeles",
            "temperature": 20.49
        },
        {
            "city": "London",
            "temperature": 9.2
        },
        {
            "city": "Philadelphia",
            "temperature": 16.09
        },
        {
            "city": "Portland",
            "temperature": 16.55
        }
    ],
    "hottestCity": {
        "city": "Los Angeles",
        "temperature": 20.49
    },
    "coldestCity": {
        "city": "London",
        "temperature": 9.2
    }
}
```