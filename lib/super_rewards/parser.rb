module SuperRewards
  class Parser
    module REXMLElementExtensions
      def text_value
        self.children.first.to_s.strip
      end
    end
    ::REXML::Element.__send__(:include, REXMLElementExtensions)
  
    def self.parse(method, data)
      parser = Parser::PARSERS[method]
      parser.process(data)
    end
  
    def self.element(name, data)
      data = data.body rescue data # either data or an HTTP response
      doc = REXML::Document.new(data)
      doc.elements.each(name) do |element|
        return element
      end
      raise "Element #{name} not found in #{data}"
    end
  end

  class GetRequiredFields < Parser
    def self.process(data)
      fields = element('users_getRequiredFields_response', data).text_value
      fields.split(',').map { |f| f.to_sym }
    end
  end

  class OffersDisplay < Parser
    def self.process(data)
      element('offers_display_response', data).text_value
    end
  end

  class User
    attr_accessor :uid, :points
  end

  class GetPoints < Parser
    def self.process(data)
      users = []
      data = data.body rescue data # either data or an HTTP response
      doc = REXML::Document.new(data)
      doc.elements.each("users_getPoints_response/user") do |element|
        user = User.new
        element.each_element("uid") do |uid_element|
          user.uid = uid_element.get_text.to_s
        end
        element.each_element("points") do |points_element|
          user.points = points_element.get_text.to_s.to_i
        end        
        users << user
      end
      users
    end
  end    

  class Parser
    PARSERS = {
      'superrewards.users.getRequiredFields' => GetRequiredFields,
      'superrewards.offers.display'          => OffersDisplay,
      'superrewards.users.getPoints'         => GetPoints
    }
  end
end