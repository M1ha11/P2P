module Claims
  class Currency
    API = 'http://www.nbrb.by/API/ExRates/Currencies'.freeze
    BYN = 'BYN'.freeze

    def currency_list
      currency_list = JSON.parse(response.body).map do |val|
        val['Cur_Abbreviation']
      end
      currency_list << BYN
      currency_list.uniq.sort
    end

    private

    def response
      HTTParty.get(API)
    end
  end
end
