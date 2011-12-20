WARNING
-------

**This is still a work in progress**

Overview
--------

This is a Rails-3.1 engine that puts your OAuth2 negotiation into a popup window. 
While it doesn't actually use Fancybox (Google's OAuth2 doesn't work in it), I tried to simulate the Fancybox experience.

Here's a demo app: http://fancy-oauth2-demo.herokuapp.com/

Compatibility
-------------

This gem is compatible with **Rails-3.1** only. It will not work on Rails 3.0 without Asset Pipeline. 

This gem has been tested with Google OAuth2 only. It might not work with other providers because of some google-specific 
login hardcoded. Please place a ticket if you find such incompatibility.

Installation
------------

TBD

Customization
-------------

TBD

Testing
-------

TBD, demo app.


Contributions
-------------

Contributions are very welcome. Here's my vision for the futher project development:

* Provider-specific logic should go into 'strategies' (e.g. GoogleStrategy)
* Build-in strategies for popular OAuth2 providers
* Better UI 
* Refactoring 
 


Credits
-------

* http://fancybox.net/
* https://github.com/intridea/oauth2

