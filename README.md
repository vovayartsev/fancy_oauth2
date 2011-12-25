WARNING
-------

**This is still a work in progress**

Overview
--------

This is a Rails-3.1 engine that puts your OAuth2 negotiation into a popup window. 
While it doesn't actually use Fancybox, it simulates the user experience of Fancybox.

This gem was extracted from a report delivery application by [VizMetrics](http://vizmetrics.com/). 
Thanks to VizMetrics for letting me publish it here.

Here's a demo app: http://fancy-oauth2-demo.herokuapp.com/

Compatibility
-------------

This gem is compatible with **Rails-3.1** only. It will not work on Rails 3.0 without Asset Pipeline. 

This gem has been tested with Google OAuth2 only. It might not work with other providers because of some google-specific 
login hardcoded. Please place a ticket if you find such incompatibility.

Installation
------------

In a Gemfile:

    gem 'fancy_oauth2', :git => 'git@github.com:vovayartsev/fancy_oauth2.git'
    
In app/assets/stylesheets/application.css

    *= require fancy_oauth2

In app/assets/javascripts/application.js

    //= require fancy_oauth2

In your view (inside a form):

    <%= form_tag .... %>
      <%= fancy_oauth2_tag :field_name, current_field_value %>
      ....

This will add a hidden input to your form, which will contain authentication token (json-encoded):
    
    <input type="hidden" name="field_name" value="<token_value>">
    
After you submit your form, you'll be able to access your token values (JSON-encoded) like this:

    json = params[:field_name]                 # => '{"access_token":"....","expires_in":3600,"refresh_token":"....."}'
    if json.present?                           # this will be a blank string if the user didn't grant the permissions 
        hash = JSON.load(json).symbolize_keys  # =>  {:access_token=>"...", :expires_in=>3600, :refresh_token=>"..."} 
    end

The actual token value is not visible to the end-user. Instead there's a colored button which is red when the hidden field is
blank, and green when there'sa token in it. The initial button color depends on the value that you pass to 
fancy_oauth2_tag call. If you don't want to expose the existing token value in HTML code, just pass some 
placeholder value, like a series of asterics. The client-side code doesn't parse this value - it displays a 
green button for any non-empty value provided. If you use this tecnique, be prepared to receive the
placeholder value back when the user submits the form.


Customization
-------------

TBD

Testing
-------

The specs are provided as a part of the demo app - see [fancy_oauth2_demo](https://github.com/vovayartsev/fancy_oauth2_demo)

Contributions
-------------

Contributions are very welcome. Here's my vision for the futher project development:

* Provider-specific logic should go into 'strategies' (e.g. GoogleStrategy)
* Build-in strategies for popular OAuth2 providers
* Better UI 
* Refactoring 
 

Credits
-------

* http://vizmetrics.com/
* https://github.com/intridea/oauth2
* http://fancybox.net/

