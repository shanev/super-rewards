require 'net/http'
require 'rexml/document'
require 'lib/super_rewards/parser'
require 'lib/super_rewards/client'

module SuperRewards
  VERSION = '0.5.2'

  SUPERREWARDS_API_KEY = "4708b7ba71f8b86aa7edc1837daf8736"
  SUPERREWARDS_SECRET_KEY = "32f168072dbefb3073ce3bd07e75f13a"
  SUPERREWARDS_ENDPOINT = "http://apps.kitnmedia.com/superrewards/service.php"
  SUPERREWARDS_VERSION = "1.0"
end