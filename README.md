# Pluckify
**Pluckify** allows you to pluck to `Hash`, `OpenStruct` or any custom class like **presenters**.

Inspired by `pluck_to_hash` gem ([github](https://github.com/girishso/pluck_to_hash)).

## Usage
```ruby
# Hash (only column name args)
User.limit(10).pluckify(:id, :first_name, 'users.last_name as last_name')
# => [ { id: 1, first_name: 'Romain', last_name: 'de Landesen' } ]

# OpenStruct
Administrator.where(id: 1).pluckify(:id, :first_name, :last_name, OpenStruct)
# => [ <#OpenStruct id=1, first_name="Romain", last_name="de Landesen"> ]

# Custom Presenter
Administrator.pluckify(:id, :first_name, :last_name, AdministratorPresenter)
# => [ #<AdministratorPresenter @model=#<OpenStruct id=1, first_name="Judge", last_name="Dredd">> ]
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'pluckify', github: 'https://github.com/rdelandesen/pluckify'
```

And then execute:

```bash
$ bundle install
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
