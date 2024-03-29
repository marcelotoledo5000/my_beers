# **MyBeers**

[![codebeat badge][codebeat-badge]][codebeat] [![Test Coverage][badge-coverage]][coverage] [![Ruby][Github-Actions]][Github]

## About this project

This project is a example to use:

- Is a Rails Application API-only. This API gives 3 resources:
  - Pubs
  - Beers
  - Styles
- Secured by HTTP Basic Authentication
- User mode, with different roles (admin, user, guest)
- CRUD
- Limit access to given part of API depending on User role:
  - Admin has access to everything
  - User can read all, create all, but update and deleted only his records
  - Guest has only read access

## Technical Informations and dependencies

``` code
* The Ruby language   # version 2.7.0
* The Rails gem       # version 6.0
* RSpec               # version 4.0.0
* Rubocop             # version 0.84.0
* PostgreSQL          # version 10
* Docker              # version 19.03.8-ce
* Docker Compose      # version 1.25.5
```

## To use

Clone the project:

``` Shell
git clone git@github.com:marcelotoledo5000/my_beers.git
cd my_beers
```

### With Docker (better option)

``` Shell
script/setup    # => development bootstrap, preparing containers
script/server   # => starts server
script/console  # => starts console
script/test     # => running tests
```

#### Running without Docker (not recommended!)

If you prefer, you'll need to update `config/database.yml`:

``` Yaml
# host: db        # when using docker
host: localhost   # when using localhost
```

System dependencies

- Install and configure the database: [Postgresql-10](https://www.postgresql.org/download/)

And then:

``` Shell
gem install bundler         # => install the last Bundler version
bundle install              # => install the project's gems
rails db:setup db:migrate   # => prepare the database
rails s                     # => starts server
rails c                     # => starts console
bundle exec rspec           # => to running tests
```

### To run app

To see the application in action, starts the rails server to able [http://localhost:3000/](http://localhost:3000.)

### Dockerfile

[Dockerfile is here](https://github.com/marcelotoledo5000/Dockerfiles)

### API Documentation

#### Authentication

- Needs to use HTTP Basic Authentication.

The format of a WWW-Authenticate header for HTTP basic authentication is:

```code
WWW-Authenticate: Basic realm="Our Site"
```

#### Domain

[http://localhost:3000/](http://localhost:3000)
Header with: user = email, pass = password

#### Endpoints

##### PUBS

INDEX

```code
GET: http://DOMAIN/pubs
"http://localhost:3000/pubs"
```

Response:

```code
200 Ok
```

SHOW

```code
GET: http://DOMAIN/pubs/ID
"http://localhost:3000/pubs/1"
```

Response:

```code
200 Ok
```

CREATE

```code
POST: http://DOMAIN/pubs
"http://localhost:3000/pubs"
Params: Body, JSON(application/json)
```

```json
{
  "name": "Delirium Cafe",
  "country": "Belgium",
  "state": "BE",
  "city": "Brussels",
  "user_id": 1
}
```

Response:

```code
201 Created
```

UPDATE

```code
PUT: http://DOMAIN/pubs/ID
"http://localhost:3000/pubs/1"
Params: Body, JSON(application/json)
```

```json
{
  "name": "BrewDog"
}
```

Response:

```code
204 No Content
```

DESTROY

```code
DELETE: http://DOMAIN/pubs/ID
"http://localhost:3000/pubs/2"
```

Response:

```code
204 No Content
```

##### STYLES

INDEX

```code
GET: http://DOMAIN/styles
"http://localhost:3000/styles"
```

Response:

```code
200 Ok
```

SHOW

```code
GET: http://DOMAIN/styles/ID
"http://localhost:3000/styles/1"
```

Response:

```code
200 Ok
```

CREATE

```code
POST: http://DOMAIN/styles
"http://localhost:3000/styles"
Params: Body, JSON(application/json)
```

```json
{
  "name": "German-Style Schwarzbier",
  "school_brewery": "German",
  "user_id": 1
}
```

Response:

```code
201 Created
```

UPDATE

```code
PUT: http://DOMAIN/styles/ID
"http://localhost:3000/styles/1"
Params: Body, JSON(application/json)
```

```json
{
  "name": "German-Style Weizenbock"
}
```

Response:

```code
204 No Content
```

DESTROY

```code
DELETE: http://DOMAIN/styles/ID
"http://localhost:3000/styles/2"
```

Response:

```code
204 No Content
```

##### BEERS

INDEX

```code
GET: http://DOMAIN/beers
"http://localhost:3000/beers"
```

Response:

```code
200 Ok
```

SHOW

```code
GET: http://DOMAIN/beers/ID
"http://localhost:3000/beers/1"
```

Response:

```code
200 Ok
```

CREATE

```code
POST: http://DOMAIN/beers
"http://localhost:3000/beers"
Params: Body, JSON(application/json)
```

```json
{
  "name": "KBS 2016",
  "style_id": 5,
  "user_id": 1,
  "abv": "11.9%",
  "ibu": "70",
  "nationality": "American",
  "brewery": "Founders",
  "description": "The best Imperial Stout of World"
}
```

Response:

```code
201 Created
```

UPDATE

```code
PUT: http://DOMAIN/beers/ID
"http://localhost:3000/beers/1"
Params: Body, JSON(application/json)
```

```json
{
  "brewery": "Founders Brewing Co"
}
```

Response:

```code
204 No Content
```

DESTROY

```code
DELETE: http://DOMAIN/beers/ID
"http://localhost:3000/beers/2"
```

Response:

```code
204 No Content
```

### Pending Actions

- Use JSON API format response
- Build a CRUD web app (with login) that consumes the API
- Change http basic auth to JWT
- Deploy on Heroku (both apps: back-end and front-end)

## Contributing

My Beers is open source, and we are grateful for
[everyone][contributors] who have contributed so far or want to start.

[badge-coverage]: https://codecov.io/gh/marcelotoledo5000/my_beers/branch/master/graph/badge.svg
[coverage]: https://codecov.io/gh/marcelotoledo5000/my_beers

[codebeat-badge]: https://codebeat.co/badges/764a1e80-cdba-4f9a-94d9-e82552cfc333
[codebeat]: https://codebeat.co/projects/github-com-marcelotoledo5000-my_beers-master

[Github-Actions]: https://github.com/marcelotoledo5000/my_beers/workflows/Ruby/badge.svg
[Github]: https://github.com/marcelotoledo5000/my_beers/workflows/Ruby/badge.svg
