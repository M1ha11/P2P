module Claims
  class Rate
    API = 'http://www.nbrb.by/API/RefinancingRate'.freeze

    def list
      interest_rate_list = interest_rate_list.map do |data|
        data['Value']
      end
      interest_rate_list
    end

    private

    def interest_rate_list
      url = "#{API}?onDate=#{Date.today.strftime('%Y-%m')}"
      JSON.parse(HTTParty.get(url).body)
    end
  end
end
