# Standout Capybara

The purpose of this gem is to make it easier to setup Capybara drivers with sane defaults. It will default to `headless_chrome`, and if you use it with nanobox it will default to `nanobox_chrome`. But feel free to overwrite the environment variable CAPYBARA to use another capybara driver.

## Installation

Add this line to your application's Gemfile:

```ruby
# Gemfile
group :development, :test do
  gem "capybara"
  gem "standout-capybara", require: false
end

# test_helper.rb, spec_helper.rb or rails_helper.rb etc
require 'capybara/rails'
require 'standout/capybara/setup'
```

And then execute:

    $ bundle

## Usage

### Headless chrome

Just run your test command, the `headless_chrome` is the default driver


### Chrome

Run the test command with `CAPYBARA=chrome`.

Example:

```bash
$ CAPYBARA=chrome rake
```

### Nanobox chrome

Add a local only component of standalone chrome to your `boxfile.yml`

```yml
data.chrome:
  image: selenium/standalone-chrome
  local_only: true
```

Now you can run the test as usual.

Example:

```bash
$ nanobox run rake
```

### Options

Options that you can override using environment variables.

| Environment variable | Description |
|:-----------------|:------------|
| `CAPYBARA`  | Override the driver |
| `CAPYBARA_WAIT_TIME`  | Override default wait time of capybara |


### Available drivers

Override the driver using the environment variable `CAPYBARA`.

Example:

```bash
CAPYBARA=[driver name] test-command
```

| Driver name      | Description |
|:-----------------|:------------|
| chrome           | Regular chrome driver that will use a visual browser window. |
| headless_chrome  | Headless chrome driver. The default driver. |
| nanobox_chrome   | Default driver when inside Nanobox. |
| remote_chrome    | Default driver when `ENV['HUB_URL']` is defined. |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/standout-capybara. This project is intended to be
a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Standout::Capybara project’s codebases, issue
trackers, chat rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/[USERNAME]/standout-capybara/blob/master/CODE_OF_CONDUCT.md).

## Release

To release a new version you should bump the version in the file
`lib/standout/capybara/version.rb`, commit the change and push it to GitHub.
Then you should create a release in GitHub and it will automatically be built
and uploaded to RubyGems and as a GitHub Package.
