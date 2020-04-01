<p align="center">
  <h3 align="center">Dirtfield of Dreams</h3>

  <p align="center">
    A brownfield API consumption project.
    <br />
    <a href="https://github.com/nkeller1"><strong>Nathan's Profile »</strong></a>
    <br />
    <a href="https://github.com/alerrian"><strong>Steve's Profile »</strong></a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
  * [Installation](#installation)
* [Production](#production)

<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

Here's a blank template to get started:
**To avoid retyping too much info. Do a search and replace with your text editor for the following:**
`nkeller1`, `repo`, `twitter_handle`, `email`


### Built With

* [Ruby](https://ruby-doc.org/)
* [Rails](https://guides.rubyonrails.org/)
* [Heroku](https://devcenter.heroku.com/categories/reference)


<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.


### Installation

Clone the repo

https://github.com/nkeller1/brownfield-of-dreams

Setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. You will need this shortly.

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Set up the API keys
```
$ bundle exec figaro install
This will create an application.yml file. In this file you will need to add Token's and API keys as follows:

YOUTUBE_API_KEY: 'YOUR API KEY HERE'
GH_USER1_TOKEN: 'YOUR TOKEN HERE'
GH_USER2_TOKEN: 'YOUR PARTNERS TOKEN HERE'

GITHUB_CLIENT_ID: 'YOUR APP CLIENT ID'
GITHUB_CLIENT_SECRET: 'YOUR APP CLIENT SECRET'

```

Run the test suite:
```ruby
$ bundle exec rspec
```

<!-- USAGE EXAMPLES -->
## Production

Visit this project on Heroku

* [Dirtfield-of-Dreams](https://dirtfield-of-dreams.herokuapp.com/)

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
