class Address < ApplicationRecord
  belongs_to :user

  validates :cep, :address, :neighborhood, :city, :district, :user_id, presence: true

  def self.find_cep_and_create(cep, user_id)
    address = Address.where(cep:, user_id:).first
    return address if address.present?

    infos = Cep.get(cep)
    Address.create!(cep: infos['cep'],
                    district: infos['uf'],
                    city: infos['cidade'],
                    neighborhood: infos['bairro'],
                    address: infos['logradouro'],
                    user_id:)
  end
end
