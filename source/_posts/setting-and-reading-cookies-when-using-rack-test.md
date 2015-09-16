---
title: 'Setting and reading cookies when using Rack::Test'
tags: ruby
date: 2015-09-16 11:25:10
---

I used the following for testing a [sinatra](www.sinatrarb.com/) app using [rspec](http://rspec.info/) and [turnip](https://github.com/jnicklas/turnip). I needed to write a feature to test that a particular request was setting a cookie with an expiry date and that it would behave correctly when a cookie was already present in the browser.

## To set a cookie with an expiry date

For example, to set the expiry date 30 days in the future:

```ruby
set_cookie "name=value; expires=#{Time.now + 30.days}"
```

## To check expiry date of a cookie set by the response

Cookies are set by the response's `Set-Cookie` header. To check the `expires` option, we need to parse the header and create `Cookie` objects:

```ruby
def cookies_from_response(response=last_response)
  Hash[response["Set-Cookie"].lines.map { |line|
    cookie = Rack::Test::Cookie.new(line.chomp)
    [cookie.name, cookie]
  }]
end
```

So now we can do something like:

```ruby
cookie = cookies_from_response["cookie_name"]
expect(cookie.expires).to be_within(5.minutes).of(30.days.from_now)
```

The `be_within` matcher is perfect her because we cannot check the exact expiry date.