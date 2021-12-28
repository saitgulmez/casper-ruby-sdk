# Casper Ruby SDK
The Ruby SDK enables developers to interact with the Casper Network.

## Requirements
Click [**```rbenv```**](https://github.com/rbenv/rbenv) or [**```here (Steps: 1, 2, 3)```**](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04) to install dependencies.

```bash
# Install bundler
gem install bundler
```
## How to install

```bash
git clone git@github.com:saitgulmez/casper-ruby-sdk.git
cd casper-ruby-sdk
# It automatically installs all the required gems located in the Gemfile
bundle install

# There are two option to install casper_sdk

# Option 1:
# Install casper_sdk that available in the https://guides.rubygems.org/
gem install casper_sdk

# Option 2:
# Install casper_sdk gem from repository
# casper_sdk-X.Y.Z.gem will be generated after running below command
gem build casper_sdk.gemspec
# (X, Y, Z depends on s.version described in the casper_sdk.gemspec)
gem install casper_sdk-X.Y.Z.gem
```

## How to build
```bash
gem build casper_sdk.gemspec
```

## How to run tests
```bash
# Install RSpec
gem install rspec
# Run the test
rpsec spec/client_spec.rb
```

## How to generate docs
```bash
# Generate documentation from source code
rdoc lib/casper_sdk.rb
```


