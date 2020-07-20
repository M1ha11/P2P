module Claims
  class Currency
    API = 'http://www.nbrb.by/API/ExRates/Currencies'.freeze
    BYN = 'BYN'.freeze

    def list
      currency_list = currency_list.map do |val|
        val['Cur_Abbreviation']
      end
      currency_list << BYN
      currency_list.uniq.sort
    end

    private

    def currency_list
      JSON.parse(HTTParty.get(API).body)
    end
  end
end
