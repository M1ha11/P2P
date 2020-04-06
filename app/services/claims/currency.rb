module Claims
  class Currency
    API = 'http://www.nbrb.by/API/ExRates/Currencies'.freeze

    def initialize
      @currencies = []
    end

    def list
      response = HTTParty.get(API)
      JSON.parse(response.body).each do |val|
        @currencies << val['Cur_Abbreviation']
      end
      @currencies << 'BYN'
      @currencies.uniq.sort
    end
  end
end
