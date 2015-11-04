## LinkShrink

Shortener is a Rails Engine Gem that makes it easy to create and interpret shortened URLs on your own domain from within your Rails application. Once installed Shortener will generate, store URLS and “unshorten” shortened URLs for your applications visitors, all whilst collecting basic usage metrics.

### Requirements

LinkShrik is a Rails 4 applications. It uses  dependancies Rails core components like ActiveRecord, ActionController, the rails routing engine and more.

### Ruby Version Support

As this is a rails 4 application a minimum Ruby version 1.9.3 is reqiured though Ruby 2.0 is preferred. In development the application uses sqlite and MySQL in production.

### Installation

In order to set up the application clone the repository:

```
 git checkout https://github.com/Tref/LinkShrink.git
```
then cd into the application root and run
```
 bundle install
```

Once the bundle has been completed set up the database and load the seed data
```
 rake db:migrate
 rake db:seed
```

### Testing

LinkShrink utilizes Minitest::Test to implement a suite of cursory unit, functional and integration tests. After installing the application and running the appropriate migrations. First, copy the example database file and enter in your database configuration details. Then run the following rake task in order to set up your test database run the test cases:
```
 cp config/database.example.yml config/database.yml
 RAILS_ENV=test rake db:create
 rake test
```

### Deployment

LinkShrink utilizes Capistrano to for deployment and is configured for servers running an Nginx web server and MySQL database. LinkShrink connects to these services the [Puma](https://github.com/puma/puma) app server gem and, the [mysql2 gem](https://github.com/brianmario/mysql2) in production. Please note that this application does not come with a database.yml checked in. You must add your production database configuration to a shared folder on your server instance at the following:
```
 /<deploy>/<root>/shared/config/database.yml
```
In order to deploy the application to a server simply run the following:
```
 cap production deploy
```
If you would like to include the seed data in your production application run the following to seed your database:
```
 cap production rails:rake:db:seed
```
### Challenges and Design Decisions
**Challenge 1: Creating url_safe encoding scheme using the least possible characters:**

Originally I had intended to to SecureRandom::urlsafe_base64. The problem with this encoding scheme is that the length of the result string is about 4/3 of the first argument n which specifies the length, in bytes, of the random number to be generated. The issue with this is that the random number generated is at least two characters long which is not the 'least possible characters'.

In order to implement this I created my own simple base65 encoding module with a url safe character set and three methods to encode and decode full_urls against this scheme. Although this method creates short_urls effectively it does so serially, not randomly rather than serially.

**Challenge 2: Validating unique full_urls with case-sensitivity**

The flow logic of validating unique, case-sensitive urls, and subsequent encoding and validating of short_urls though manageable. had a bit more logic than I expected. I made the design decision to downcase all full urls before validating them and sending them to the database.

### Future Improvements
- Searchable, Paginated index page for all shortened urls
- Pull title and screenshot from linked site
- add authentication to /links admin section
- Populate database with migration rather than existing db/seeds.rb file
- Better integration testing with RSpec, Capybara
- Better on-site redirection UX
- Implement new Russian doll caching on top 100 list
- Use configuration file for deployment & configuration environment variables
- Implement auto-generated short_urls with DB locking

### Contributing
New feature requests are welcome, code is more welcome still. Code must include testing (where applicable).



<!--
### Full Stack Challenge:

Your mission, should you choose to accept it, is to build a URL shortener.

### Basic Requirements:
* Code must be on github
* The short code for the URL must be the shortest possible
* User should be able to put a URL into the home page and get back a unique short URL
* User should be redirected to the full URL when we enter the short URL
* User should be able to view a top 100 board with the most frequently accessed URLs
* There should be a Gemfile for any application dependencies
* There should be a test suite (RSpec, MiniTest, etc)
* There must be a README that explains the following:
  * How to setup and install the application
  * Challenges, and how you overcame them
  * Reasoning behind any design decisions
  * How you came up with the short URL scheme
  * Future improvements you would make with more time

### Bonus:
* There should be a script to setup a server with all requirements (web server, ruby, gems, database, etc)
* The application should be deployable with Capistrano to a fresh server

### Additional Information:
* The web framework you use is completely up to you.  We use Rails and Sinatra pretty extensively at BeenVerified.
* You can use whatever database you are comfortable with.  At BeenVerified we use MySQL, Redis, Cassandra, Mongo, and MariaDB.
* Feel free to use any front-end frameworks for your HTML/CSS/JS.  We use Bootstrap on most of our projects.
* Part I is where we look to see a bit of how you approach application design so feel free to show off a bit and highlight these items in your README.
* The Bonus section is for those of you with a bit more operations experience. Given a blank server, how would you set it up from scratch?  Custom bash scripts?  Chef?  Capistrano tasks?

### One last thing:
If you decide not to take on the bonus portion, and your database choice is compatible with Heroku then please push the application to Heroku.  Please do not make your database decision based on what Heroku is compatible with.
-->