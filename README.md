# OmniAuth IBM-ISAM Strategy 

This is a OmniAuth 1.0 compatible strategy.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-ibmisam'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-ibmisam
    
## Usage

Use like any other OmniAuth strategy:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ibmisam, name: 'ibmisam', header_type: 'identity'
end
```

### Configuration Options

#### Optional

Non required options:

  * `name` - Defaults to `'ibmisam'`. This becomes part of the authentication request path: `/auth/[name]`.
  * `header_type` - Defaults to `'identity'`. Can be `'eai'` or `'identity'`. 
    * `'eai'`: a header named `'am-eai-user-id'` is expected to contain the user id (user's email). 
    * `'identity'` (default): a header named `'iv-user'` is expected to contain the user id (user's email). 
  
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

