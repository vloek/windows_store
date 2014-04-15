# WindowsStore

Windows Store receipt verify gem

## Installation

Add this line to your application's Gemfile:

    gem 'windows_store'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install windows_store

## Usage
    WindowsStore.verify! File.read('receipt.xml')


## Test

    $ rake spec
    
## Contributing

1. Fork it ( http://github.com/vloek/windows_store/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
