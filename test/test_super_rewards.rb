require 'test/unit'
require 'digest/md5'
require 'cgi'
require 'rubygems'
require 'shoulda'
require 'super_rewards'

class TestSuperRewards < Test::Unit::TestCase
  
  TEST_UID = "1342314"
  
  context "Using curl" do
    setup do
      @params = {}
      @params[:api_key] = SuperRewards::SUPERREWARDS_API_KEY
      @params[:version] = SuperRewards::SUPERREWARDS_VERSION
    end
    
    context "for a single user" do
      setup do
        @params[:uid] = TEST_UID
      end
      
      should "get required fields" do
        @params[:method] = "superrewards.users.getRequiredFields"
        out = `curl -d "#{curl_params}" #{SuperRewards::SUPERREWARDS_ENDPOINT}`      
        assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?><users_getRequiredFields_response>affiliations,birthday,sex,meeting_for</users_getRequiredFields_response>", out
      end

      should "get offer display code" do
        @params[:method] = "superrewards.offers.display"
        @params[:display_mode] = "iframe"
        # TODO: sending the XML user_info always gives us an invalid signature
        # @params[:user_info] = CGI.escape(user_info.to_s)
        out = `curl -d "#{curl_params}" #{SuperRewards::SUPERREWARDS_ENDPOINT}`
        assert_match(/<offers_display_response>/, out)
      end
    end
    
    should "get points for the given users" do
      @params[:method] = "superrewards.users.getPoints"
      @params[:uids] = TEST_UID
      out = `curl -d "#{curl_params}" #{SuperRewards::SUPERREWARDS_ENDPOINT}`
      assert_match(/users_getPoints_response list=\"true\"/, out)      
    end
  end
  
  context "Using SuperRewards Ruby API" do
    should "get required fields" do
      fields = SuperRewards::Client.get_required_fields(TEST_UID)
      [ :affiliations, :birthday, :sex, :meeting_for ].each do |field|
        assert fields.include?(field)
      end
    end
    
    should "get offer display code" do
      offer_code = SuperRewards::Client.offers_display(:iframe, TEST_UID, nil)
      assert_match(/offers.php/, offer_code)
    end
    
    should "get points for the given users" do
      uids = [TEST_UID, "1234"]
      users = SuperRewards::Client.get_points(uids)
      assert_equal TEST_UID, users.first.uid
      assert_equal 0, users.first.points
    end
  end

private
  def curl_params
    @params.map { |k,v| "#{k}=#{v}" }.join('&') + "&sig=#{signature_for(@params)}"
  end  
  
  def signature_for(params)
    raw_string = params.inject([]) do |collection, pair|
      collection << pair.join("=")
      collection
    end.sort.join
    Digest::MD5.hexdigest([SuperRewards::SUPERREWARDS_SECRET_KEY, raw_string].join)
  end
  
  def user_info
    xml =<<EOF
<?xml version='1.0' encoding='UTF-8'?>
<users_getInfo_response xmlns='http://api.facebook.com/1.0/'
xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
xsi:schemaLocation='http://api.facebook.com/1.0/ http://api.facebook.com/1.0/facebook.xsd' list='true'>
  <user>
    <uid>8055</uid>
    <affiliations list='true'>
      <affiliation>
        <nid>50453093</nid>
        <name>Facebook Developers</name>
        <type>work</type>
        <status/>
        <year/>
      </affiliation>
    </affiliations> 
    <birthday>November 3</birthday>
     <meeting_for list='true'>
       <seeking>Friendship</seeking>
     </meeting_for>
     <sex>male</sex>
  </user>
</users_getInfo_response>
EOF
  xml.gsub!(/[\t\r\n]/,'') 
  end
  
end
