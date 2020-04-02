module ClaimsHelper
  class ClaimCurrencyHelper
    API = 'http://www.nbrb.by/API/ExRates/Currencies'.freeze
  
    def initialize
      @currencies = []
    end
  
    def currency
      response = HTTParty.get(API)
      JSON.parse(response.body).each do |val|
        @currencies << val['Cur_Abbreviation']
      end
      @currencies
    end
  end

  class ClaimRateHelper
    API = 'http://www.nbrb.by/API/RefinancingRate'.freeze
  
    def initialize
      @rate = []
    end  
  
    def rate
      url = "#{API}?onDate=#{Date.today.strftime('%Y-%m-%d')}"
      response = HTTParty.get(url)
      JSON.parse(response.body).each do |data|
        @rate << data['Value']
      end
      @rate
    end
  end
end