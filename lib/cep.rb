class Cep
  URL = 'http://cep.la'.freeze

  def self.get(cep)
    response = HTTParty.get("#{URL}/#{cep}", headers: { "Accept": 'application/json' })
    raise 'CEP not found' unless response.present?

    response
  end
end
