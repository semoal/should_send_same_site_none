![Ruby Gem CI](https://github.com/semoal/should_send_same_site_none/workflows/Ruby%20Gem%20CI/badge.svg?branch=master)
# ShouldSendSameSiteNone

With this gem you can check a user-agent is compatible with `SameSite:none` cookie.

## Background

With Chrome 80 in February 2020, Chrome will treat cookies that have no declared SameSite value as `SameSite=Lax` cookies. Other browser vendors are expected to follow Google’s lead. (See this [Blog Post](https://blog.chromium.org/2019/10/developers-get-ready-for-new.html)).

If you manage cross-site cookies, you will need to apply the SameSite=None; Secure setting to those cookies. However, some browsers, including some versions of Chrome, Safari and UC Browser, might handle the None value in unintended ways, requiring developers to code exceptions for those clients.

`isSameSiteNoneCompatible` utility function detects incompatible user agents based on a [list of known incompatible clients](https://www.chromium.org/updates/same-site/incompatible-clients) and returns `true` if the given user-agent string is compatible with `SameSite=None` cookie attribute.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'should_send_same_site_none'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install should_send_same_site_none

## Usage

This gem was originally created to check on Ruby on Rails redis session store, if we can pass same_site or not for ex:

Look code at: https://github.com/semoal/redis-actionpack
```ruby
# redis-action-pack gem
def set_cookie(env, _session_id, cookie)
    request = wrap_in_request(env)
    if (request.user_agent.present? && ShouldSendSameSiteNone.is_same_site_compatible(value))
        if (cookie[:same_site].present? && cookie[:same_site] == :none)
            cookie.delete(:same_site)
        end
        cookie_jar(request)[key] = cookie.merge(cookie_options)
    else
        cookie_jar(request)[key] = cookie.merge(cookie_options)
    end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/should_send_same_site_none. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/should_send_same_site_none/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ShouldSendSameSiteNone project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/should_send_same_site_none/blob/master/CODE_OF_CONDUCT.md).

## Intersting links

- [JS Package](https://github.com/linsight/should-send-same-site-none)
- [Ruby on Rails Session Store with this logic, for avoiding problems on rails app](https://github.com/semoal/redis-actionpack)

