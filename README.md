# Chunker

[![Build Status](https://travis-ci.org/xarisd/chunker.svg?branch=master)](https://travis-ci.org/xarisd/chunker)

A small utility that reads and writes files in chunks. Also a [Rack](http://rack.github.io) middleware (or endpoint) for chunkable and resumable file uploads, compatible with the [tus](http://www.tus.io) protocol.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chunker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chunker

## Usage

### As a library

TODO: Write usage instructions here

### As a Rack middleware

TODO: Write usage instructions here

### As a Rack endpoint

TODO: Write usage instructions here


## Contributing

1. Fork it ( https://github.com/xarisd/chunker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)

  3.1. Make sure to write tests AND test the whole library by simply:

  ````bash
  rake
  ````

4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
