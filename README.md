# SMS4 Ruby Client

This is the Ruby client library for [SMS4](https://www.sms4.dev).

This library provides a function for sending text messages via sms4 API.

## Installation

```bash
gem install sms4
```

## Usage

```ruby
require 'sms4'

# result is a json server response. see docs for details
# token is provided via SMS4_TOKEN environment variable
result = SMS4.send('+123456798', 'The server is down!')
puts result

# multiple numbers are supported and you can pass token via
# 3rd argument to send function
result = SMS4.send(['+123456798', '+123456799'], 'The server is down!', 'YOUR_TOKEN')
puts result
```