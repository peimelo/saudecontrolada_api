# Controlled Health API

Controlled Health website API built with [Ruby on Rails](https://rubyonrails.org/) as API and using [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth).

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      2.7.2
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.0.3.4
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      Postgres
    </td>
  </tr>
</table>

The frontend of this repository was built with Angular and is called [controlled-health-frontend](https://github.com/peimelo/controlled-health-frontend).

## Configuration

```bash
git clone https://github.com/peimelo/controlled_health_api.git
cd controlled_health_api

# installation of dependencies
bundle

# creation of database and tables
rails db:create
rails db:migrate

# run the project
rails s
```

## Tests

[![CircleCI](https://circleci.com/gh/peimelo/saudecontrolada_api.svg?style=svg)](https://circleci.com/gh/peimelo/saudecontrolada_api)

To run the tests:

```bash
bundle exec rspec
```

## Configuration to use Docker

```bash
# upload the web and database instances
docker-compose up -d

# creation of tables
docker-compose exec web bundle exec rails db:migrate

# creation of database and test tables
docker-compose exec web bundle exec rails db:create RAILS_ENV=test
docker-compose exec web bundle exec rails db:migrate RAILS_ENV=test

# run the tests
docker-compose exec web bundle exec rspec

# stop the instances
docker-compose stop
```
