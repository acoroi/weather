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