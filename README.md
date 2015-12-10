# SimpleMenu

This gem create based on fwmenu of brianfwz https://github.com/brianfwz/fwmenu

Remove article and category

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_menu', :git => 'https://github.com/oliverfwz/simple_menu.git'
```

And then execute:

    $ bundle

    $ rails g simple_menu:install

    $ rails g simple_menu:admin

    $ rake db:migrate

## Usage

Login admin to create positions, menus, menuitems

Add this line to your layout you want render menu with position you create in admin.

		= render partial: "simple_menu/menus", locals: { position: "pos_menu_head" }

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/oliverfwz/simple_menu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
