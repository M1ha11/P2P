class ClaimCurrency
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