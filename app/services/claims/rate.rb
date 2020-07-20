module Claims
  class Rate
    API = 'http://www.nbrb.by/API/RefinancingRate'.freeze

    def list
      list = interest_rate_list.map do |data|
        data['Value']
      end
      list
    end

    private

    def interest_rate_list
      url = "#{API}?onDate=#{Date.today.strftime('%Y-%m')}"
      JSON.parse(HTTParty.get(url).body)
    end
  end
end
