module SuperRewards
  class Client
    def self.get_required_fields(uid)
      instance.post('superrewards.users.getRequiredFields', :uid => uid)
    end

    def self.offers_display(mode, uid, user_info=nil)
      if user_info
        instance.post('superrewards.offers.display', :display_mode => mode.to_s, :uid => uid, :user_info => user_info)
      else
        instance.post('superrewards.offers.display', :display_mode => mode.to_s, :uid => uid)
      end        
    end

    def self.get_points(uids)
      instance.post('superrewards.users.getPoints', :uids => uids.join(','))
    end
    
    def post(method, params = {})
      params[:method] = method
      params[:api_key] = SUPERREWARDS_API_KEY
      params[:version] = SUPERREWARDS_VERSION
      service.post(params.merge(:sig => signature_for(params)))
    end
    
  private
    def self.instance
      @instance ||= self.new
    end
  
    def service
      @service ||= Service.new
    end

    def signature_for(params)
      raw_string = params.inject([]) do |collection, pair|
        collection << pair.join("=")
        collection
      end.sort.join
      Digest::MD5.hexdigest([SUPERREWARDS_SECRET_KEY, raw_string].join)
    end
  end
  
  class Service
    def post(params)
      Parser.parse(params[:method], Net::HTTP.post_form(url, params))
    end
  private
    def url
      URI.parse(SUPERREWARDS_ENDPOINT)
    end
  end  
end