require 'net/http'
require 'rexml/document'
require 'lib/super_rewards/parser'
require 'lib/super_rewards/client'

module SuperRewards
  VERSION = '0.5.2'

  SUPERREWARDS_API_KEY = "CHANGE ME"
  SUPERREWARDS_SECRET_KEY = "CHANGE ME"
  SUPERREWARDS_ENDPOINT = "http://apps.kitnmedia.com/superrewards/service.php"
  SUPERREWARDS_VERSION = "1.0"
end