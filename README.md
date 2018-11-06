[![Build Status](https://travis-ci.org/marcelotoledo5000/my_beers.svg?branch=master)](https://travis-ci.org/marcelotoledo5000/my_beers)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae4ce2a36d05fb5fcabf/maintainability)](https://codeclimate.com/github/marcelotoledo5000/my_beers/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ae4ce2a36d05fb5fcabf/test_coverage)](https://codeclimate.com/github/marcelotoledo5000/my_beers/test_coverage)

<h3>This project uses:</h3>

* The Ruby language - version 2.5.1
* The Rails gem - version 5.2.1
* RSpec: 3.8.1
* Rubocop: 0.60

<h4>To use:</h4>

Clone the project:

<pre>
$ git clone git@github.com:marcelotoledo5000/my_beers.git
$ cd my_beers
</pre>

<h4>With Docker:</h4>

- Needs to update `database.yml` to:
<pre>
# host: localhost  # when using localhost
host: db  # when using docker
</pre>

<pre>
$ script/setup # => development bootstrap, preparing containers
$ script/server # => starts server
$ script/console # => starts console
$ script/test # => running tests
</pre>

<h4>Running Local:</h4>

<h6>System dependencies:</h6>

* Install and configure the database: [Postgresql-10](https://www.postgresql.org/download/)

- Needs to update `database.yml` to:
<pre>
host: localhost  # when using localhost
# host: db  # when using docker
</pre>

<pre>
$ bundle install
$ rails db:setup
</pre>

<h4>To run the tests</h4>

<pre>
$ bundle exec rspec
</pre>

<h4>To run app</h4>

To check that application runs properly by entering the command:

<pre>
$ bundle exec rails server
</pre>

To see the application in action, starts the rails server to able [http://localhost:3000/](http://localhost:3000.) => DOMAIN

<h3>More about this project:</h3>

Is a Rails application API-only. This API gives 3 resources:
- Pubs
- Beers
- Styles

Authentication:
- HTTP Basic Authentication (user = email, pass = password)

User mode - with different roles (admin, user, guest).

Endpoints:

<h5>To Pubs:</5>
<pre>
INDEX
GET: http://DOMAIN/pubs
curl -u "admin@email.com:12345678" "http://localhost:3000/pubs"
</pre>
<pre>
SHOW
GET: http://DOMAIN/pubs/:id
curl -u "admin@email.com:12345678" "http://localhost:3000/pubs/:id"
</pre>
<pre>
CREATE
POST: http://DOMAIN/pubs
</pre>
<pre>
UPDATE
PUT: http://DOMAIN/pubs/:id
</pre>
<pre>
DESTROY
DELETE: http://DOMAIN/pubs/:id
</pre>

<h5>To Styles:</5>
<pre>
INDEX
GET: http://DOMAIN/styles
curl -u "admin@email.com:12345678" "http://localhost:3000/styles"
</pre>
<pre>
SHOW
GET: http://DOMAIN/styles/:id
curl -u "admin@email.com:12345678" "http://localhost:3000/styles/:id"
</pre>
<pre>
CREATE
POST: http://DOMAIN/styles
</pre>
<pre>
UPDATE
PUT: http://DOMAIN/styles/:id
</pre>
<pre>
DESTROY
DELETE: http://DOMAIN/styles/:id
</pre>

<h5>To Beers:</5>
<pre>
INDEX
GET: http://DOMAIN/beers
curl -u "admin@email.com:12345678" "http://localhost:3000/beers"
</pre>
<pre>
SHOW
GET: http://DOMAIN/beers/:id
curl -u "admin@email.com:12345678" "http://localhost:3000/beers/:id"
</pre>
<pre>
CREATE
POST: http://DOMAIN/beers
</pre>
<pre>
UPDATE
PUT: http://DOMAIN/beers/:id
</pre>
<pre>
DESTROY
DELETE: http://DOMAIN/beers/:id
</pre>
