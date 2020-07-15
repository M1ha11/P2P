module Claims
  class Rate
    API = 'http://www.nbrb.by/API/RefinancingRate'.freeze

    def interest_rate_list
      interest_rate_list = JSON.parse(response.body).map do |data|
        data['Value']
      end
      interest_rate_list
    end

    private

    def response
      url = "#{API}?onDate=#{Date.today.strftime('%Y-%m')}"
      response = HTTParty.get(url)
    end
  end
end
