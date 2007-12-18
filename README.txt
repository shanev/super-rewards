SuperRewards
    by Shane Vitarana
    http://shanesbrain.net

== DESCRIPTION:
  
A Ruby client for the Super Rewards API by KITN Media

== FEATURES/PROBLEMS:
  
* Aims to implement all the functionality of the Super Rewards PHP client

== SYNOPSIS:

  offer_code = SuperRewards::Client.offers_display(:iframe, uid)
	points = SuperRewards::Client.get_points(uids).first.user.points

== REQUIREMENTS:

* API / Secret keys for the Super Rewards service
* Shoulda gem (for testing)

== INSTALL:

* sudo gem install super_rewards

== LICENSE:

(The MIT License)

Copyright (c) 2007 Shane Vitarana

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
