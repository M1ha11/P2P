module Claims
  class Rate
    API = 'http://www.nbrb.by/API/RefinancingRate'.freeze

    def initialize
      @rate = []
    end  

    def list
      url = "#{API}?onDate=#{Date.today.strftime('%Y-%m-%d')}"
      response = HTTParty.get(url)
      JSON.parse(response.body).each do |data|
        @rate << data['Value']
      end
      @rate
    end
  end
end
